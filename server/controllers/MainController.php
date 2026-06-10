<?php
namespace app\controllers;

use app\core\Response;
use app\services\ProductsService;
use app\services\MainService;

/** Контролер для получения главной информации */
readonly class MainController {
    public function __construct(
        private ProductsService $productsService,
        private MainService     $mainService
    ) {}

    /**
     * Получение основной информации
     *
     * @return Response
     */
    public function infoAction(): Response {
        $products = $this->productsService->getHitAndSales();
        $news = $this->mainService->getNews();

        return Response::jsonSuccess(data: [
            'slider' => $news,
            'popular' => $products['hit'] ?? [],
            'sales' => $products['sales'] ?? []
        ]);
    }
}