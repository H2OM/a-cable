<?php

namespace app\controllers;

use app\core\enums\ResponseMessage;
use app\core\exceptions\ResponseException;
use app\core\Request;
use app\core\Response;
use app\services\CategoriesService;
use app\services\ProductsService;


/** Управление каталогом */
class CatalogController {
    public function __construct(
        private readonly Request $request,
        private readonly ProductsService $productsService,
        private readonly CategoriesService $categoriesService
    ) {}

    /**
     * Получение каталога товара
     *
     * @return Response
     * @throws ResponseException
     */
    public function getAction(): Response {
        $filters_params = $this->request->get();

        if(empty($filters_params['category'])) {
            return Response::jsonError(message: ResponseMessage::ERROR_DATA);
        }

        $catalog = $this->productsService->getCatalogByFilters($filters_params);
        $filters = $this->productsService->getFiltersGroupByCode($filters_params['category']);
        $category = $catalog[0]['category_parent'] ?? null;

        if(empty($category)) {
            $category = $this->categoriesService->getByCode($filters_params['category'])['title'] ?? null;
        }

        return Response::jsonSuccess(data: [
            'category_title' => $category,
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