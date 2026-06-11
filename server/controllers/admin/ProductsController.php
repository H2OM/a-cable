<?php

namespace app\controllers\admin;

use app\core\enums\ResponseMessage;
use app\core\exceptions\ResponseException;
use app\core\Request;
use app\core\Response;
use app\services\admin\ProductsService;

/** Контроллер для управления товарами */
readonly class ProductsController {
    public function __construct(
        private ProductsService $productsService,
        private Request         $request
    ) {}

    /**
     * Привязка вариации к товару
     *
     * @return Response
     * @throws ResponseException
     */
    public function pairVariationAction(): Response {
        $id          = (int)$this->request->input('id');
        $variationId = (int)$this->request->input('variation_id');
        $oneWay      = (bool)$this->request->input('one_way');

        if (!$id || !$variationId) {
            throw new ResponseException(ResponseMessage::ERROR_NOT_ENOUGH_DATA);
        }

        if(!$this->productsService->pairVariation($id, $variationId, $oneWay)) {
            throw new ResponseException(ResponseMessage::ERROR_ADD);
        }

        return Response::jsonSuccess(message: ResponseMessage::SUCCESS_ADD);
    }

    /**
     * Удаление товаров по id
     *
     * @return Response
     * @throws ResponseException
     */
    public function deleteAction(): Response {
        $ids = $this->request->input('ids');

        if(empty($ids)) {
            throw new ResponseException(ResponseMessage::ERROR_NOT_ENOUGH_DATA);
        }

        $result = $this->productsService->deleteByIds($ids);

        if(!$result) {
            throw new ResponseException(ResponseMessage::ERROR_DELETE);
        }

        return Response::jsonSuccess(message: ResponseMessage::SUCCESS_REMOVE_ITEMS);
    }

    /**
     * Присваивание товарам статуса - хит продаж
     *
     * @return Response
     * @throws ResponseException
     */
    public function makeHitAction(): Response {
        $ids = $this->request->input('ids');

        if(empty($ids) || !is_array($ids)) {
            throw new ResponseException(ResponseMessage::ERROR_NOT_ENOUGH_DATA);
        }

        $result = $this->productsService->makeHit($ids);

        if(!$result) {
            throw new ResponseException(ResponseMessage::ERROR_UPDATE);
        }

        return Response::jsonSuccess(message: ResponseMessage::SUCCESS_UPDATE_DATA);
    }

    /**
     * Удаление у товаров статуса - хит продаж
     *
     * @return Response
     */
    public function excludeHitAction(): Response {

    }
}