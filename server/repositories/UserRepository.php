<?php

namespace app\repositories;

use app\core\Db;
use app\core\Hydrator;

/** Репозиторий для управления пользователями */
class UserRepository {
    public function __construct(private readonly Db $db, private readonly Hydrator $hydrator) {}

    /**
     * Получение данных админа по логину
     *
     * @param string $login
     * @return array|null
     */
    public function getAdminByLogin(string $login): ?array {
        $response = $this->db->fetchOne("
            SELECT 
	            admins.*,
                IF(COUNT(p.id) > 0,
                    JSON_ARRAYAGG(JSON_OBJECT(
                        'id', p.id, 
                        'name', p.name
                    )),
                    JSON_ARRAY()
                ) AS permissions  
              FROM admins
              LEFT JOIN admins_permissions ON admins.id = admins_permissions.admin_id
              LEFT JOIN permissions AS p ON admins_permissions.permission_id = p.id
              WHERE admins.login = ?;
        ", [$login]);

        if(!is_array($response)) return null;

        return $this->hydrator->decodeJson($response, ['permissions']);
    }

    /**
     * Получения пользователя по номеру телефона
     *
     * @param string $phone
     * @return array|null
     */
    public function getByPhone(string $phone): ?array {
        return $this->db->query()
            ->table('users')
            ->where('phone', $phone)
            ->first();
    }

    /**
     * Добавление нового пользователя
     *
     * @param array $userData
     * @return string|false
     */
    public function insert(array $userData): string|false {
        return $this->db->query()
            ->table('users')
            ->insert($userData)
            ->insertId();
    }

    /**
     * Редактирование пользователя
     *
     * @param int $userId
     * @param array $userData
     * @return bool
     */
    public function edit(int $userId, array $userData): bool {
        return $this->db->query()
            ->table('users')
            ->where('id', '=', $userId)
            ->update($userData)
            ->execute();
    }
}