<?php

namespace app\services\admin;

use app\repositories\CategoriesRepository;

/** Сервис для управления категориями */
class CategoriesService {
    public function __construct(private readonly CategoriesRepository $categoriesRepository) {}

    /**
     * Прикрепить фильтры к категориям
     *
     * @param array $values
     * @return bool
     */
    public function addFiltersToCategories(array $values): bool {
        return $this->categoriesRepository->addFiltersToCategories($values);
    }
}