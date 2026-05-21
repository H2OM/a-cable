<?php

namespace app\services\admin;

use app\repositories\BrandsRepository;

/** Сервис для управления брендами */
class BrandsService {
    public function __construct(private readonly BrandsRepository $brandsRepository) {}

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