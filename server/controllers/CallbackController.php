<?php

namespace app\controllers;

use app\core\enums\ResponseMessage;
use app\core\Request;
use app\core\Response;
use app\services\CallbackService;
use Exception;

/** Контролер для управления обратной связи */
readonly class CallbackController {
    public function __construct(
        private Request         $request,
        private CallbackService $callbackService) {}

    /**
     * Обработка формы подписки на новости
     *
     * @return Response
     * @throws Exception
     */
    public function subscribeAction(): Response {
        $email = $this->request->input('email');

        if(!$email) {
            return Response::jsonError(message: ResponseMessage::ERROR_DATA, status: 403);
        }

        $this->callbackService->subscribe(email: $email);

        return Response::jsonSuccess(message: ResponseMessage::SUCCESS_SUBSCRIBE);
    }

    /**
     * Обработка формы обратной связи
     *
     * @return Response
     * @throws Exception
     */
    public function formAction(): Response {
        $this->callbackService->form(data: $this->request->input());

        return Response::jsonSuccess(message: ResponseMessage::SUCCESS_FORM);
    }
}