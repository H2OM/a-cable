<?php

namespace app\services\admin;

use app\core\enums\ResponseMessage;
use app\core\exceptions\ResponseException;
use app\core\Validator;
use app\repositories\UserRepository;

/** Сервис для управления авторизацией в админ-панели */
class AuthService {
    public function __construct(
        private readonly UserRepository $userRepository,
        private readonly Validator      $validator,

    ) {}

    /**
     * Логирование по логину и паролю
     *
     * @param string $login
     * @param string $password
     * @return array
     * @throws ResponseException
     */
    public function login(string $login, string $password): array {
        $validateData = $this->validator->validate(
            data: [
                'login' => $login,
                'password' => $password,
            ],
            rules: [
                'login' => ['required', 'login'],
                'password' => ['required', 'password'],
            ]
        );

        if (!$validateData) {
            throw new ResponseException(ResponseMessage::ERROR_AUTH_LOGIN_DATA);
        }

        $admin = $this->userRepository->getAdminByLogin($login);

        if(empty($admin) || !password_verify($validateData['password'], $admin['password'])) {
            throw new ResponseException(ResponseMessage::ERROR_AUTH_LOGIN_DATA);
        }

        unset($admin['password']);

        return $admin;

    }
}