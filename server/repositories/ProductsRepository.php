<?php

namespace app\repositories;

use app\core\Db;
use app\core\Hydrator;

/** Репозиторий для управления товарами */
class ProductsRepository {
    private const PRODUCTS_WITH_VARIATIONS_SQL = "SELECT products.*, categories_types.name AS category, categories_types.code as category_code,
                                            brands.name as brand, products_stocks.count as stock,
                                            IF(COUNT(var_p.id) > 0,
                                               JSON_ARRAYAGG(JSON_OBJECT('id', var_p.id, 'image', var_p.image)),
                                               JSON_ARRAY()
                                            ) AS variations
                                        FROM products 
                                        JOIN categories_types ON products.category_type_id = categories_types.id
                                        LEFT JOIN products_stocks ON products_stocks.product_id = products.id
                                        LEFT JOIN brands ON products.brand_id = brands.id
                                        LEFT JOIN products_variations ON (products.id = products_variations.product_id OR products.id = products_variations.variation_id)
                                        LEFT JOIN products AS var_p ON (products_variations.variation_id = var_p.id OR products_variations.product_id = var_p.id) AND var_p.id != products.id
                                        WHERE (%s)
                                        GROUP BY products.id;";

    public function __construct(private readonly Db $db, private readonly Hydrator $hydrator) {}

    /**
     * Получение популярных и скидочных товаров
     *
     * @return array
     */
    public function getHitAndSales(): array {
        return $this->hydrator->decodeJson(
            $this->db->fetchAll(sprintf(
                self::PRODUCTS_WITH_VARIATIONS_SQL,
                "products.hit = '1' OR products.price_old > 0"
            )),
            ['variations']
        );
    }

    /**
     * Получение товаров по фильтрам
     *
     * @param array $filters
     * @return array
     */
    public function getByFilters(array $filters): array {
        $sqlPartSelect = "";
        $whereCondition = "";
        $prepareSelectedValue = [];
        $prepareConditionedValue = [];

        $index = 1;

        foreach ($filters as $key => $value) {
            if($key === 'sort') continue;

            switch($key) {
                case "category":
                    $whereCondition .= "categories.code = ? AND ";

                    $prepareConditionedValue[] = $value;

                    break;
                case "price":
                    $price = explode(",", $value);

                    if(count($price) === 2 && is_numeric($price[0]) && is_numeric($price[1])) {
                        $whereCondition .= "products.price <= ? AND products.price >= ? AND ";

                        array_push($prepareConditionedValue, $price[1], $price[0]);
                    }

                    break;
                case "sale":
                    switch($value) {
                        case "yes":
                            $whereCondition .= "products.price <= (products.price_old * 1) AND ";

                            break;
                        case "no":
                            $whereCondition .= "products.price_old  = 0 AND ";

                            break;
                        default:
                            break;
                    }

                    break;
//                    TODO Фильтрация по тип, бренду и всех фильтров
                case "brand":
                case "size":
                case "color":
                case "type":
                    $filter = explode(",", $value);

                    if(count($filter) >= 1) {
                        $sqlPartSelect .= "(SELECT goods.id AS ID FROM goods JOIN filters_goods ON filters_goods.goods_id = goods.id 
                                                    JOIN filters_values ON filters_values.id = filters_goods.filter_value_id JOIN filters 
                                                    ON filters.id = filters_values.filter_id WHERE (";

                        foreach($filter as $field) {
                            $sqlPartSelect .= "COALESCE(filters_values.code, filters_values.id) = ? OR ";

                            $prepareSelectedValue[] = $field;
                        }

                        $sqlPartSelect = substr_replace($sqlPartSelect, ")", -4);
                        $sqlPartSelect .= " AND filters.code = ? GROUP BY goods.id) AS {$index}s, ";

                        $prepareSelectedValue[] = $key;

                        $whereCondition .= "goods.id = {$index}s.ID AND ";
                    }

                    break;
                default:
                    break;
            }

            $index++;
        }

        if(strlen($whereCondition) > 0) {
            $whereCondition = " WHERE ". substr_replace($whereCondition, "", -5);
        }

        $whereCondition .= " GROUP BY products.id";

        if(isset($filters['sort'])) {
            $whereCondition .= match ($filters['sort']) {
                'low-to-high' => ' ORDER BY products.price ASC',
                'high-to-low' => ' ORDER BY products.price DESC',
                default => ''
            };
        }

        return $this->hydrator->decodeJson($this->db->fetchAll("
            SELECT 
                products.*, 
                categories_types.name AS category, 
                categories_types.code as category_code,
                brands.name as brand, 
                products_stocks.count as stock,
                (
                    SELECT COALESCE(JSON_ARRAYAGG(JSON_OBJECT('id', vp.id, 'image', vp.image)), JSON_ARRAY())
                    FROM products_variations p_v
                    JOIN products vp ON (p_v.variation_id = vp.id OR p_v.product_id = vp.id) AND vp.id != products.id
                    WHERE p_v.product_id = products.id OR p_v.variation_id = products.id
                ) AS variations
            FROM ".$sqlPartSelect."filters_values_products 
            JOIN products ON filters_values_products.product_id = products.id
            JOIN filters_values ON filters_values_products.filter_value_id = filters_values.id 
            JOIN filters ON filters_values.filter_id = filters.id
            JOIN categories_types ON products.category_type_id = categories_types.id
            JOIN categories ON categories_types.category_id = categories.id 
            LEFT JOIN products_stocks ON products_stocks.product_id = products.id
            LEFT JOIN brands ON products.brand_id = brands.id
                $whereCondition
        ", [...$prepareSelectedValue, ...$prepareConditionedValue]), ['variations']);
    }

    /**
     * Получение отдельного товара с подробностями по id
     *
     * @param int $id
     * @return array|null
     */
    public function getProductDetailsById(int $id): array|null {
       return $this->db->fetchOne("SELECT goods.*, base.value AS color, categories.code AS category, 
                                        GROUP_CONCAT(filters_values.value SEPARATOR '.') AS size, mods.colors 
                                        FROM (SELECT GROUP_CONCAT(CONCAT(goods.id, ';', goods.article, ';', categories.code, ';', goods.image) SEPARATOR ',') AS colors 
                                        FROM goods_variations JOIN goods ON (goods_variations.base_id = goods.id OR goods_variations.variation_id = goods.id) 
                                        JOIN categories ON goods.category_id = categories.id 
                                        WHERE (goods_variations.base_id = ? OR goods_variations.variation_id = ?) ORDER BY goods_variations.base_article DESC) AS mods, 
                                        (SELECT filters_values.value FROM goods JOIN filters_goods ON filters_goods.goods_id = goods.id 
                                        JOIN filters_values ON filters_goods.filter_value_id = filters_values.id JOIN filters ON filters_values.filter_id = filters.id 
                                        AND filters.code = 'color' WHERE goods.id = ?) AS base, 
                                        goods JOIN categories ON goods.category_id = categories.id JOIN filters_goods ON filters_goods.goods_id = goods.id 
                                        JOIN filters_values ON filters_goods.filter_value_id = filters_values.id 
                                        JOIN filters ON filters_values.filter_id = filters.id AND filters.code = 'size' 
                                        WHERE goods.id = ?",
            array_fill(0, 4, $id));
    }

    /**
     * Получение связанных товаров по id
     *
     * @param int $id
     * @return array
     */
    public function getRelatedById(int $id): array {
        return $this->db->fetchAll("SELECT goods.*, categories.code AS category, 
                                        GROUP_CONCAT(filters_values.value SEPARATOR '.') AS size FROM goods_related 
                                        JOIN goods ON goods_related.goods_id = goods.id OR goods_related.related_id = goods.id 
                                        JOIN filters_goods JOIN filters_values JOIN filters ON filters_values.filter_id = filters.id 
                                        AND filters.code = 'size' AND filters_goods.goods_id = goods.id AND filters_goods.filter_value_id = filters_values.id 
                                        JOIN categories ON goods.category_id = categories.id 
                                        WHERE (goods_related.goods_id = ? OR goods_related.related_id = ?) 
                                        AND goods.id != ? GROUP BY goods.id",
            array_fill(0, 3, $id));
    }

    /**
     * Получение наличия товара по id
     *
     * @param int $id
     * @return int
     */
    public function getProductId(int $id): int {
        return $this->db->query()
            ->table('products')
            ->where('id', $id)
            ->value('id');
    }

    /**
     * Получение товаров по id
     *
     * @param array $id
     * @return array
     */
    public function getProductsById(array $id): array {
        return $this->db->fetchAll($this->prepareProductsById([$id]), [$id]);
    }

    /**
     * Получение отдельного товара по id
     *
     * @param int $id
     * @return array|null
     */
    public function getProductById(int $id): array|null {
        return $this->db->fetchOne($this->prepareProductsById([$id]), [$id]);
    }

    /**
     * Получение товаров по id с вариациями
     *
     * @param array $ids
     * @return array
     */
    public function getProductsWithVariationsById(array $ids): array {
        $placeholders = implode(',', array_fill(0, count($ids), '?'));

        return $this->hydrator->decodeJson(
            $this->db->fetchAll(sprintf(
                self::PRODUCTS_WITH_VARIATIONS_SQL,
                "products.id IN ($placeholders)"
            ), $ids),
            ['variations']
        );
    }

    /**
     * Получение отдельного товара по id с вариациями
     *
     * @param int $id
     * @return array|null
     */
    public function getProductWithVariationsById(int $id): array|null {
        $response = $this->db->fetchOne(sprintf(
            self::PRODUCTS_WITH_VARIATIONS_SQL,
            "products.id = ?"
        ), [$id]);

        if(!is_array($response)) return null;

        return $this->hydrator->decodeJson($response, ['variations']);
    }

    /**
     * Подготовка запроса на получения товара/товаров по id
     *
     * @param array $ids
     * @return string
     */
    private function prepareProductsById(array $ids): string {
        $placeholders = implode(',', array_fill(0, count($ids), '?'));

        return "SELECT products.*, categories_types.name AS category, categories_types.code as category_code, 
                    brands.name as brand, products_stocks.count as stock
                FROM products 
                JOIN categories_types ON products.category_type_id = categories_types.id
                LEFT JOIN products_stocks ON products_stocks.product_id = products.id
                LEFT JOIN brands ON products.brand_id = brands.id
                WHERE products.id IN ($placeholders)
                GROUP BY products.id;";
    }
}