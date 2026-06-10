<?php

namespace app\controllers;

use app\core\enums\ResponseMessage;
use app\core\exceptions\ResponseException;
use app\core\Request;
use app\core\Response;
use app\services\ProductsService;

/** Контроллер для получения товаров */
readonly class ProductsController {
    public function __construct(
        private ProductsService $productsService,
        private Request         $request
    ) {}

    /**
     * Получение всех товаров
     *
     * @return Response
     */
    public function getAllAction(): Response {
        $page = (int)$this->request->get('page', 1);
        $limit = (int)$this->request->get('limit', 20);

        $products = $this->productsService->getAllByLimit($page, $limit);

        return Response::jsonSuccess(data: $products);
    }

    /**
     * Получение количества товаров
     *
     * @return Response
     */
    public function getCountAction(): Response {
        $categoryTypeId = $this->request->get('category_type_id');
        $brandId = $this->request->get('brand_id');

        $count = $this->productsService->getCount($categoryTypeId, $brandId);

        return Response::jsonSuccess(data: $count);
    }

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