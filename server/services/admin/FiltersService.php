<?php

namespace app\services\admin;

use app\repositories\FiltersRepository;

/** Сервис для управления фильтрами */
class FiltersService {
    public function __construct(private readonly FiltersRepository $filtersRepository) {}

    /**
     * Вставка новых фильтров
     *
     * @param array $filters
     * @return string|false
     */
    public function insert(array $filters): string|false {
        return $this->filtersRepository->insert($filters);
    }

    /**
     * Вставка новых значений фильтров
     *
     * @param array $filtersValues
     * @return string|false
     */
    public function insertFiltersValues(array $filtersValues): string|false {
        return $this->filtersRepository->insertFiltersValues($filtersValues);

    }

    /**
     * Вставка новых связей значений фильтра и id товара
     *
     * @param array $filtersValuesProducts
     * @return string|false
     */
    public function insertFiltersValuesProducts(array $filtersValuesProducts): string|false {
        return $this->filtersRepository->insertFiltersValuesProducts($filtersValuesProducts);
    }
}