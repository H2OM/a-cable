<?php

namespace app\services\admin;

use app\core\enums\ResponseMessage;
use app\core\Env;
use app\core\exceptions\ResponseException;
use app\repositories\BrandsRepository;
use app\repositories\parsers\AnlanRepository;
use Exception;

/** Парсер для сайта АнЛан */
class AnlanParserService extends ParserService {
    public function __construct(
        private readonly AnlanRepository  $anlanRepository,
        private readonly BrandsRepository $brandsRepository,
        private readonly ProductsService  $productsService,
        private readonly FiltersService   $filtersService,
        private readonly Env              $env
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
        $parsedProducts = array_values($parsedProducts);
        $products = [];
        $brandsMap = [];

        foreach ($parsedProducts as $parseProduct) {
            $images = [];

            if(!empty($parseProduct['images_filename'])) {
                foreach ($parseProduct['images_filename'] as $key => $image) {
                    $imageUrl = $this->env->get('PARSER_ANLAN_IMAGES_URL') . "/" . $image['image'];
                    $imageLocal = $parseProduct['id'] . '_' . $key . '_' . $image['image'];

                    if($this->getImage($imageUrl, $imageLocal)) {
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
            // TODO старт транзакции
            $firstProductId = $this->productsService->insert($products);

            if(!$firstProductId) {
                throw new ResponseException(ResponseMessage::ERROR_ADD_PRODUCT);
            }

            $productsStocks = [];
            $filters = [];
            $filtersValues = [];
            $filtersValuesProducts = [];

            foreach($parsedProducts as $index => $parsedProduct) {
                $productId = (int)$firstProductId + $index;

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

            $this->productsService->insertStock($productsStocks);

            $firstFilterId = $this->filtersService->insertFilters($filters);
            $parsedFiltersValues = [];

            foreach(array_values($filtersValues) as $index => $filterValues) {
                $filterId = (int)$firstFilterId + $index;

                foreach($filterValues as $filterValue) {
                    $parsedFiltersValues[] = [
                        ...$filterValue,
                        'filter_id' => $filterId,
                    ];
                }
            }

            $firstFilterValueId = $this->filtersService->insertFiltersValues(array_map(function ($value) {
                return [
                    'value' => $value['value'],
                    'code' => $value['code'],
                    'filter_id' => $value['filter_id'],
                ];
            }, $parsedFiltersValues));

            $parsedFiltersValuesProducts = [];

            foreach($parsedFiltersValues as $index => $parsedFiltersValue) {
                $filtersValueId = (int)$firstFilterValueId + $index;
                $fvp = $filtersValuesProducts[$parsedFiltersValue['filter_code']][$parsedFiltersValue['code']];

                foreach($fvp as $filterValueProduct) {
                    $parsedFiltersValuesProducts[] = [
                        'product_id' => $filterValueProduct['product_id'],
                        'filter_value_id' => $filtersValueId
                    ];
                }
            }

            $this->filtersService->insertFiltersValuesProducts($parsedFiltersValuesProducts);

            return true;
        } catch (Exception $e) {
            // TODO ролбек
            throw $e;
        }
    }
}