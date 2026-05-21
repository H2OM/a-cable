<?php

namespace app\repositories;

use app\core\Db;
use app\core\Hydrator;

/** Репозиторий для управления категориями */
class CategoriesRepository {
    public function __construct(private readonly Db $db, private readonly Hydrator $hydrator) {}

    /**
     * Получение всех категорий и их подтипов
     *
     * @return array
     */
    public function getAll(): array {
        return $this->hydrator->decodeJson(
            $this->db->query()
                ->table('categories')
                ->select('*')
                ->addSelect("
                    (
                        SELECT 
                            COALESCE(JSON_ARRAYAGG(JSON_OBJECT(
                                'id', categories_types.id,
                                'name', categories_types.name,
                                'code', categories_types.code
                            )), JSON_ARRAY())
                        FROM categories_types
                        WHERE categories_types.category_id = categories.id
                    ) AS types
                ")
                ->get(),
            ['types']
        );
    }

    /**
     * Получить по коду
     *
     * @param string $code
     * @return array|null
     */
    public function getByCode(string $code): ?array {
        return $this->db->query()
            ->table('categories')
            ->select('*')
            ->where('code', '=', $code)
            ->first();
    }
}