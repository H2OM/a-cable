<?php

namespace app\services\admin;

use app\core\Db;

/** Сервис для управления товарами */
class ProductsService {
    public function __construct(private readonly Db $db) {}

    /**
     * Добавление новых товаров
     *
     * @param array $data
     * @return string|false
     */
    public function insert(array $data): string|false {
        return $this->db->query()
            ->table('products')
            ->insert($data)
            ->insertId();
    }

    /**
     * Добавление наличия товаров
     *
     * @param array $data
     * @return bool
     */
    public function insertStock(array $data): bool {
        return $this->db->query()
            ->table('products')
            ->insert($data)
            ->execute();
    }
}