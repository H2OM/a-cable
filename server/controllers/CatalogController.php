<?php

namespace app\controllers;

use app\core\enums\ResponseMessage;
use app\core\exceptions\ResponseException;
use app\core\Request;
use app\core\Response;
use app\services\ProductsService;


/** Управление каталогом */
class CatalogController {
    public function __construct(private readonly Request $request, private readonly ProductsService $productsService) {}

    /**
     * Получение каталога товара
     *
     * @return Response
     * @throws ResponseException
     */
    public function getAction(): Response {
        $filters = $this->request->get();

        if(empty($filters['category'])) {
            return Response::jsonError(message: ResponseMessage::ERROR_DATA);
        }

        $catalog = $this->productsService->getCatalogByFilters($filters);
        $filters = $this->productsService->getFiltersGroupByCode($filters['category']);

        return Response::jsonSuccess(data: [
            'catalog' => $catalog,
            'filters' => $filters
        ]);
    }

    /**
     * Получение отдельного товара
     *
     * @return Response
     * @throws ResponseException
     */
    public function getProductAction(): Response {
        $id = (int)$this->request->get('id');

        if(!$id || !is_numeric($id)) {
            return Response::jsonError(message: ResponseMessage::ERROR_NOT_ENOUGH_DATA, status: 403);
        }

        $product = $this->productsService->getProductById($id);
        $relatedProducts = $this->productsService->getRelatedById($id);

        return Response::jsonSuccess(data: [
            'product' => $product,
            'related' => $relatedProducts,
        ]);
    }
}