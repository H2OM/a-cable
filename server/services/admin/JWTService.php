<?php

namespace app\services\admin;

use Firebase\JWT\JWT;

/** Сервис для управления jwt токенами */
class JWTService {
    private const HOURS_TO_EXPIRE = 2;

    public function __construct() {}

    /**
     * Генерация токена
     *
     * @param array|null $data
     * @return string
     */
    public function generateToken(?array $data): string {
        $adminId = 1;
        $adminName = "Алексей";
        $permissions = ['product.create', 'product.edit', 'products']; // Сюда подтягиваете массив прав из БД

        $issuedAt = time();
        $expireAt = $issuedAt + self::HOURS_TO_EXPIRE * 3600;

        $payload = [
            'iss' => $_ENV['JWT_ISSUER'], // Кто выпустил токен (Issuer)
            'aud' => $_ENV['JWT_AUDIENCE'], // Для кого выпущен (Audience)
            'iat' => $issuedAt, // Время выпуска
            'exp' => $expireAt, // Время окончания
            'data' => [
                'id'          => $adminId,
                'name'        => $adminName,
                'permissions' => $permissions
            ]
        ];

        // Генерируем токен
        $jwt = JWT::encode($payload, $_ENV['JWT_SECRET_KEY'], 'HS256');

        // Отправляем токен и базовые данные на фронтенд админки
        return [
            'success' => true,
            'token' => $jwt,
            'user' => [
                'name' => $adminName,
                'permissions' => $permissions
            ]
        ];
    }
}