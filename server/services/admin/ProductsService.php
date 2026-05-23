<?php

namespace app\services\admin;

use app\repositories\ProductsRepository;

/** Сервис для управления товарами */
class ProductsService {
    public function __construct(private readonly ProductsRepository $productsRepository) {}

    /**
     * Добавление новых товаров
     *
     * @param array $data
     * @return array|false
     */
    public function insert(array $data): array|false {
        return $this->productsRepository->insert($data);
    }

    /**
     * Добавление наличия товаров
     *
     * @param array $data
     * @return bool
     */
    public function insertStock(array $data): bool {
        return $this->productsRepository->insertStock($data);
    }
}