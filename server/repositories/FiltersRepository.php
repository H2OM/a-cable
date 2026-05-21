<?php

namespace app\repositories;

use app\core\Db;

/** Репозиторий для управления фильтрами */
class FiltersRepository {
    public function __construct(private readonly Db $db) {}

    /**
     * Получение всех фильтров
     *
     * @param string $categoryCode
     * @return array
     */
    public function getFilters(string $categoryCode): array {
        return $this->db->fetchAll("
            WITH target_types AS (
                SELECT ct.id
                FROM categories_types ct
                JOIN categories c ON ct.category_id = c.id
                WHERE c.code = ?
            )
            SELECT
                filters.id,
                filters.filter AS filter_name,
                filters.code AS filter_code,
                filters.type,
                filters.position,
                CASE
                    WHEN filters.id = 5 THEN CONCAT(MIN(products.price), ',', MAX(products.price))
                    WHEN filters.id = 4 THEN brands.name
                    WHEN filters.id = 3 THEN categories_types.name
                    ELSE filters_values.value
                END AS value_name,
                CASE
                    WHEN filters.id = 5 THEN CONCAT(MIN(products.price), ',', MAX(products.price))
                    WHEN filters.id = 4 THEN brands.code
                    WHEN filters.id = 3 THEN categories_types.code
                    ELSE filters_values.code
                END AS value_code,
                CASE
                    WHEN filters.id = 5 THEN 'price_range'
                    WHEN filters.id = 4 THEN CONCAT('b_', brands.id)
                    WHEN filters.id = 3 THEN CONCAT('c_', categories_types.id)
                    ELSE filters_values.id
                END AS value_id
            FROM filters
            LEFT JOIN filters_values ON filters.id = filters_values.filter_id
            LEFT JOIN categories_filters ON filters.id = categories_filters.filter_id
            LEFT JOIN categories ON categories_filters.category_id = categories.id
            LEFT JOIN products ON products.category_type_id IN (SELECT id FROM target_types)
            LEFT JOIN brands ON filters.id = 4 AND products.brand_id = brands.id
            LEFT JOIN categories_types ON filters.id = 3 AND products.category_type_id = categories_types.id
            LEFT JOIN filters_values_products ON products.id = filters_values_products.product_id AND filters_values.id = filters_values_products.filter_value_id
            WHERE
                (categories.code = ? OR filters.id IN (1, 2, 3, 4, 5))
                AND (
                    (filters.id = 5 AND products.id IS NOT NULL) OR
                    (filters.id = 4 AND brands.id IS NOT NULL) OR
                    (filters.id = 3 AND categories_types.id IS NOT NULL) OR
                    (filters.id IN (1, 2) AND filters_values.id IS NOT NULL) OR
                    (filters.id NOT IN (1, 2, 3, 4, 5) AND filters_values.id IS NOT NULL AND filters_values_products.filter_value_id IS NOT NULL)
                )
            GROUP BY
                filters.id,
                IF(filters.id = 5, 'price', value_id)
            ORDER BY
                 filters.position ASC, value_name ASC;
        ", [$categoryCode, $categoryCode]);
    }

    /**
     * Вставка новых фильтров
     *
     * @param array $filters
     * @return string|false
     */
    public function insertFilters(array $filters): string|false {
        return $this->db->query()
            ->table('filters')
            ->insert($filters)
            ->insertId();
    }

    /**
     * Вставка новых значений фильтров
     *
     * @param array $filtersValues
     * @return string|false
     */
    public function insertFiltersValues(array $filtersValues): string|false {
        return $this->db->query()
            ->table('filters_values')
            ->insert($filtersValues)
            ->insertId();
    }

    /**
     * Вставка новых связей значений фильтра и id товара
     *
     * @param array $filtersValuesProducts
     * @return string|false
     */
    public function insertFiltersValuesProducts(array $filtersValuesProducts): string|false {
        return $this->db->query()
            ->table('filters_values_products')
            ->insert($filtersValuesProducts)
            ->insertId();
    }
}