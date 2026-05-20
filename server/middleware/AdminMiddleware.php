<?php

namespace app\middleware;

use app\core\enums\ResponseMessage;
use app\core\exceptions\ResponseException;
use Exception;

class AdminMiddleware implements MiddlewareInterface {
    /** Имя пространства защищенных классов */
    private const NAMESPACE = "admin";

    /**
     * Получение имени пространства защищенных классов
     *
     * @return string
     */
    public function getNamespace(): string {
        return self::NAMESPACE;
    }

    /**
     * Проверка JWT-токена
     *
     * @param string|null $requiredPermission
     * @return bool
     * @throws ResponseException
     */
    public function handle(?string $requiredPermission = null): bool {
        $headers = getallheaders();
        $authHeader = $headers['Authorization'] ?? $headers['authorization'] ?? '';

        if (!str_starts_with($authHeader, 'Bearer ')) {
            throw new ResponseException(ResponseMessage::ERROR_NOT_AUTH, 401);
        }

        $token = str_replace('Bearer ', '', $authHeader);

        try {
            $secretKey = $_ENV['JWT_SECRET_KEY'] ?? 'your-very-secret-key';
            $decoded = JWT::decode($token, new Key($secretKey, 'HS256'));
            $adminData = (array) $decoded->data;
            $adminPermissions = $adminData['permissions'] ?? [];

            if($requiredPermission && !in_array($requiredPermission, $adminPermissions)) {
                throw new ResponseException(ResponseMessage::ERROR_PERMISSIONS, 403);
            }

            // Сохраняем данные админа в глобальный массив или статический класс,
            // чтобы к ним был доступ из контроллеров
            $_REQUEST['admin_data'] = (array) $decoded->data;

            return true;
        } catch (ResponseException $e) {
            throw $e;
        } catch (Exception $e) {
            throw new ResponseException(ResponseMessage::ERROR_TOKEN, 401);
        }
    }
}