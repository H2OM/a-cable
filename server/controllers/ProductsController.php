<?php

namespace app\controllers;

use app\core\enums\ResponseMessage;
use app\core\exceptions\ResponseException;
use app\core\Request;
use app\core\Response;
use app\services\ProductsService;

/** Контроллер для получения товаров */
class ProductsController {
    public function __construct(
        private readonly ProductsService $productsService,
        private readonly Request $request
    ) {}

    /**
     * Поиск id товаров
     *
     * @return Response
     * @throws ResponseException
     */
    public function searchIdsAction(): Response {
        $query = $this->request->get('query');

        if(empty($query)) {
            throw new ResponseException(ResponseMessage::ERROR_NOT_ENOUGH_DATA);
        }

        $findProducts = $this->productsService->searchIdsByQuery($query);

        return Response::jsonSuccess(data: $findProducts);
    }
}