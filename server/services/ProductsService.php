<?php

namespace app\services;

use app\core\enums\ResponseMessage;
use app\core\exceptions\ResponseException;
use app\core\Hydrator;
use app\core\Session;
use app\repositories\FiltersRepository;
use app\repositories\ProductsRepository;

/** Сервис для получения товаров */
class ProductsService {
    public function __construct(
        private readonly FiltersRepository  $filtersRepository,
        private readonly ProductsRepository $productsRepository,
        private readonly FavoritesService   $favoritesService,
        private readonly Session            $session,
    ) {}

    /**
     * Получение популярных и скидочных товаров
     *
     * @return array[]
     */
    public function getHitAndSales(): array {
        $products = $this->productsRepository->getHitAndSales();

        $hit = [];
        $sales = [];

        foreach($products as $product) {
            if($product['hit'] === '1') {
                $hit[] = $product;
            }
            if((float)$product['price_old'] > 0) {
                $sales[] = $product;
            }
        }

        return ['hit' => $hit, 'sales' => $sales];
    }

    /**
     * Получение каталога товаров с фильтрацией
     *
     * @param array $filters
     * @return array
     */
    public function getCatalogByFilters(array $filters): array {
        $catalog = $this->productsRepository->getByFilters($filters);

        if(count($catalog) === 0 || !isset($filters['favorite'])) return $catalog;

        $favorites = $this->session->get('favorites');

        if(empty($favorites)) $favorites = $this->favoritesService->get();

        $showOnlyFavorites = filter_var($filters['favorite'], FILTER_VALIDATE_BOOLEAN);

        return array_filter($catalog, function ($product) use ($favorites, $showOnlyFavorites) {
            $isFavorite = in_array($product['id'], $favorites);

            return $showOnlyFavorites ? $isFavorite : !$isFavorite;
        });
    }

    /**
     * Получение всех фильтров
     *
     * @param string $categoryCode
     * @return array
     * @throws ResponseException
     */
    public function getFilters(string $categoryCode): array {
        $filters = $this->filtersRepository->getFilters($categoryCode);

        if(count($filters) === 0) {
            throw new ResponseException(ResponseMessage::ERROR_DATA, 403);
        }

        return $filters;
    }

    /**
     * Получение всех фильтров сгруппированных по коду
     *
     * @param string $categoryCode
     * @return array
     * @throws ResponseException
     */
    public function getFiltersGroupByCode(string $categoryCode): array {
        $filters = $this->getFilters($categoryCode);

        $groupedFilters = [];

        foreach($filters as $filter) {
            $code = $filter['filter_code'];

            if(!isset($groupedFilters[$code])) {
                $groupedFilters[$code] = [
                    'code' => $code,
                    'name' => $filter['filter_name'],
                    'type' => $filter['type'],
                    'position' => $filter['position'],
                    'values' => []
                ];
            }

            $groupedFilters[$code]['values'][] = [
                'id' => $filter['value_id'],
                'name' => $filter['value_name'],
                'code' => $filter['value_code'],
            ];
        }

        return array_values($groupedFilters);
    }

    /**
     * Получение всех фильтров сгруппированных по типу
     *
     * @param string $categoryCode
     * @return array
     * @throws ResponseException
     */
    public function getFiltersGroupByType(string $categoryCode): array {
        $filters = $this->getFilters($categoryCode);

        $groupedFilters = [];

        foreach($filters as $filter) {
            if($filter['name'] === "" && $filter['value_code'] === "") {
                continue;
            }

            $type = $filter['type'];

            if(!isset($groupedFilters[$type])) {
                $groupedFilters[$type] = [];
            }

            $index = "";

            foreach($groupedFilters[$type] as $key => $value) {
                if(isset($type['code']) && $value['code'] == $filter['code']) {
                    $index = $key;

                    break;
                }
            }

            if($index !== "") {
                $groupedFilters[$type][$index]["values"][] = [
                    "name" => $filter["name"],
                    "value_code" => $filter['value_code']
                ];
            } else {
                $groupedFilters[$type][] = [
                    "filter" => $filter['filter'],
                    "code" => $filter['code'],
                    "values" => [
                        [
                            "name" => $filter["name"],
                            "value_code" => $filter['value_code']
                        ]
                    ]
                ];
            }
        }

        return $groupedFilters;
    }

    /**
     * Получение отдельного товара по id
     *
     * @param int $id
     * @return array
     * @throws ResponseException
     */
    public function getProductById(int $id): array {
        $product = $this->productsRepository->getProductDetailsById($id);

        if(!$product) {
            throw new ResponseException(ResponseMessage::ERROR_GET_DATA);
        }

        if(count($product) === 0) {
            throw new ResponseException(ResponseMessage::ERROR_PRODUCT_NOT_FOUND, 404);
        }

        $localFilters = [];

        foreach ($product['local_filters'] as $filter) {
            if(!isset($localFilters[$filter['filter_code']]['values'])) {
                $localFilters[$filter['filter_code']] = [
                    'name' => $filter['filter_name'],
                    'code' => $filter['filter_code'],
                    'values' => []
                ];
            }

            $localFilters[$filter['filter_code']]['values'][] = [
                'name' => $filter['value_name'],
                'code' => $filter['value_code'],
                'product_id' => $filter['product_id'],
            ];
        }

        $product['local_filters'] = array_values($localFilters);

        return $product;
    }

    /**
     * Получение связанных товаров по id
     *
     * @param int $id
     * @return array
     */
    public function getRelatedById(int $id): array {
        return $this->productsRepository->getRelatedById($id);
    }
}