<?php

namespace app\services;

use app\repositories\BrandsRepository;

/** Сервис для получения брендов */
readonly class BrandsService {
    public function __construct(private BrandsRepository $brandsRepository) {}

    /**
     * Получение по коду
     *
     * @param string $code
     * @return array|null
     */
    public function getByCode(string $code): ?array {
        return $this->brandsRepository->getByCode($code);
    }
}