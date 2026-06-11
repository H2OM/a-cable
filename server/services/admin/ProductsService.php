<?php

namespace app\services\admin;

use app\repositories\ProductsRepository;

/** Сервис для управления товарами */
readonly class ProductsService {
    public function __construct(private ProductsRepository $productsRepository) {}

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

    /**
     * Удаление товаров по Id
     *
     * @param array $ids
     * @return bool
     */
    public function deleteByIds(array $ids): bool {
        return $this->productsRepository->deleteByIds($ids);
    }

    /**
     * Привязка вариаций к товару
     *
     * @param int $id
     * @param int $variationId
     * @param bool $oneWay
     * @return bool
     */
    public function pairVariation(int $id, int $variationId, bool $oneWay = false): bool {
        $data = [[
            'product_id' => $id,
            'variation_id' => $variationId,
        ]];

        if(!$oneWay) {
            $data[] = ['product_id' => $variationId, 'variation_id' => $id];
        }

        return $this->productsRepository->pairVariation($data);
    }

    /**
     * Присваивание товарам статуса хит продаж
     *
     * @param array $ids
     * @return bool
     */
    public function makeHit(array $ids): bool {
        return $this->productsRepository->makeHit($ids);
    }
}