<?php

namespace app\services;

use app\repositories\CategoriesRepository;

/** Сервис для управления категориями */
class CategoriesService {
    public function __construct(private readonly CategoriesRepository $categoriesRepository) {}

    /**
     * Получение всех категорий
     *
     * @return array
     */
    public function getAll(): array {
        return $this->categoriesRepository->getAll();
    }

    /**
     * Получить по коду
     *
     * @param string $code
     * @return array|null
     */
    public function getByCode(string $code): ?array {
        return $this->categoriesRepository->getByCode($code);
    }
}