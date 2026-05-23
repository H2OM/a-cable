<?php

namespace app\services\admin\parsers;

use app\core\Db;
use app\core\enums\ResponseMessage;
use app\core\Env;
use app\core\exceptions\ResponseException;
use app\repositories\BrandsRepository;
use app\repositories\CategoriesRepository;
use app\repositories\FiltersRepository;
use app\repositories\parsers\AnlanRepository;
use app\repositories\ProductsRepository;
use Exception;

/** Парсер для сайта АнЛан */
class AnlanParserService extends ParserService {
    public function __construct(
        private readonly CategoriesRepository $categoriesRepository,
        private readonly ProductsRepository   $productsRepository,
        private readonly FiltersRepository    $filtersRepository,
        private readonly BrandsRepository     $brandsRepository,
        private readonly AnlanRepository      $anlanRepository,
        private readonly Env                  $env,
        private readonly Db                   $db
    ) {}

    /**
     * Взять товары из АнЛан
     *
     * @param array $data
     * @return array
     * @throws Exception
     */
    public function from(array $data): array {
        $products = $this->anlanRepository->getProducts($data['brand_id'], $data['categories_codes'], $data['limit']);

        file_put_contents(__DIR__ . '/data/products.json', json_encode(
            value: $products,
            flags: JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE
        ));

        return $products;
    }

    /**
     * Загрузить в текущую базу товары из АнЛан
     *
     * @param array $parsedProducts
     * @param int $categoryTypeId
     * @return bool
     * @throws ResponseException
     * @throws Exception
     */
    public function to(array $parsedProducts, int $categoryTypeId): bool {
        $mainCategory = $this->categoriesRepository->getMainCategoryByTypeId($categoryTypeId);
        $parsedProducts = array_values($parsedProducts);
        $products = [];
        $brandsMap = [];

        foreach ($parsedProducts as $parseProduct) {
            $images = [];

            if(!empty($parseProduct['images_filename'])) {
                foreach ($parseProduct['images_filename'] as $key => $image) {
                    $imageUrl = $this->env->get('PARSER_ANLAN_IMAGES_URL') . "/" . $image['image'];
                    $imageLocal = $parseProduct['id'] . '_' . $key . '_' . $image['image'];

                    if($this->imageExists($imageLocal) || $this->getImage($imageUrl, $imageLocal)) {
                        $images[] = $imageLocal;
                    }
                }
            }

            if(empty($brandsMap[$parseProduct['brand_code']])) {
                $currentBrand = $this->brandsRepository->getByCode(strtolower($parseProduct['brand_code']));

                $brandsMap[$parseProduct['brand_code']] = $currentBrand['id'] ?? 4;
            }

            $products[] = [
                'title' => $parseProduct['name'],
                'brand_id' => $brandsMap[$parseProduct['brand_code']],
                'category_type_id' => $categoryTypeId,
                'article' => $parseProduct['sku'],
                'price' => $parseProduct['price'],
                'price_old' => 0,
                'unit' => $parseProduct['units'] ?? 'шт.',
                'image' => $images[0] ?? '',
                'slider_images' => implode(',', $images),
                'description' => $parseProduct['description'],
                'hit' => 0
            ];
        }

        try {
            $this->db->beginTransaction();

            if(!$this->productsRepository->insert($products)) {
                throw new ResponseException(ResponseMessage::ERROR_ADD_PRODUCT);
            }

            $productsIds = $this->productsRepository->getProductsIdsByArticle(array_map(function ($product) {
                return $product['article'];
            }, $products));

            $productsIds = array_column($productsIds, null, 'article');

            $productsStocks = [];
            $filters = [];
            $filtersValues = [];
            $filtersValuesProducts = [];

            foreach($parsedProducts as $parsedProduct) {
                $productId = $productsIds[$parsedProduct['sku']]['id'] ?? null;

                $productsStocks[] = [
                    'product_id' => $productId,
                    'count' => mt_rand(0, 200),
                ];

                foreach($parsedProduct['filters'] as $parsedFilter) {
                    if(empty($filters[$parsedFilter['filter_code']])) {
                        $filters[$parsedFilter['filter_code']] = [
                            'filter' => $parsedFilter['filter_name'],
                            'code' => $parsedFilter['filter_code'],
                            'type' => 'multi'
                        ];
                    }

                    $filtersValues[$parsedFilter['filter_code']][$parsedFilter['value_code']] = [
                        'value' => $parsedFilter['value'],
                        'code' => $parsedFilter['value_code'],
                        'filter_code' => $parsedFilter['filter_code']
                    ];

                    $filtersValuesProducts[$parsedFilter['filter_code']][$parsedFilter['value_code']][] = [
                        'product_id' => $productId
                    ];
                }
            }

            $this->productsRepository->insertStock($productsStocks);

            if(!$this->filtersRepository->insert($filters)) {
                throw new ResponseException(ResponseMessage::ERROR_ADD_FILTERS);
            }

            $filtersIds = $this->filtersRepository->getFiltersIdsByCode(array_map(function ($filter) {
                return $filter['code'];
            }, $filters));

            $filtersIds = array_column($filtersIds, null, 'code');

            $parsedFiltersValues = [];
            $categoriesFilters = [];

            foreach($filtersValues as $filterCode => $filterValues) {
                $filterId = $filtersIds[$filterCode]['id'] ?? null;

                foreach($filterValues as $filterValue) {
                    $parsedFiltersValues[] = [
                        ...$filterValue,
                        'filter_id' => $filterId,
                    ];
                }

                $categoriesFilters[] = [
                    'category_id' => $mainCategory['id'],
                    'filter_id' => $filterId
                ];
            }

            $this->categoriesRepository->addFiltersToCategories($categoriesFilters);

            $result = $this->filtersRepository->insertFiltersValues(array_map(function ($value) {
                return [
                    'value' => $value['value'],
                    'code' => $value['code'],
                    'filter_id' => $value['filter_id'],
                ];
            }, $parsedFiltersValues));

            if(!$result) {
                throw new ResponseException(ResponseMessage::ERROR_ADD_FILTERS);
            }

            $filtersValuesIds = $this->filtersRepository->getFiltersValuesIdsByCode(array_map(function ($filterValue) {
                return $filterValue['code'];
            }, $parsedFiltersValues));

            $filtersValuesIds = array_column($filtersValuesIds, null, 'code');

            $parsedFiltersValuesProducts = [];

            foreach($parsedFiltersValues as $parsedFiltersValue) {
                $filtersValueId = $filtersValuesIds[$parsedFiltersValue['code']]['id'] ?? null;
                $fvp = $filtersValuesProducts[$parsedFiltersValue['filter_code']][$parsedFiltersValue['code']];

                foreach($fvp as $filterValueProduct) {
                    $parsedFiltersValuesProducts[] = [
                        'product_id' => $filterValueProduct['product_id'],
                        'filter_value_id' => $filtersValueId
                    ];
                }
            }

            if(!$this->filtersRepository->insertFiltersValuesProducts($parsedFiltersValuesProducts)) {
                throw new ResponseException(ResponseMessage::ERROR_ADD_FILTERS);
            }

            $this->db->commit();

            return true;
        } catch (Exception $e) {
            $this->db->rollBack();

            throw $e;
        }
    }
}