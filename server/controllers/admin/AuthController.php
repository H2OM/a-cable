<?php

namespace app\controllers\admin;

use app\core\enums\ResponseMessage;
use app\core\exceptions\ResponseException;
use app\core\Request;
use app\core\Response;

class AuthController {

    public function __construct(private readonly Request $request) {}

    /**
     * Логирование
     *
     * @return Response
     * @throws ResponseException
     */
    public function loginAction(): Response {
        $login = $this->request->input('login');
        $password = $this->request->input('password');

        if(empty($login) || empty($password)) {
            throw new ResponseException(ResponseMessage::ERROR_NOT_ENOUGH_DATA);
        }




    }
}