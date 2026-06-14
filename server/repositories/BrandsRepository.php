<?php

namespace app\repositories;

use app\core\Db;

/** Репозиторий для управления брендами */
readonly class BrandsRepository {
    public function __construct(private Db $db) {}

    /**
     * Получение по коду
     *
     * @param string $code
     * @return array|null
     */
    public function getByCode(string $code): ?array {
        return $this->db->query()
            ->table('brands')
            ->where('code', '=', $code)
            ->first();
    }

    /**
     * Поиск бренда по строке запроса
     *
     * @param string $query
     * @return array
     */
    public function searchByQuery(string $query): array {
        return $this->db->query()
            ->table('brands')
            ->where('id', 'LIKE', "$query%")
            ->orWhere('name', 'LIKE', "%$query%")
            ->orWhere('code', 'LIKE', "%$query%")
            ->limit(10)
            ->get();
    }
}