<?php

namespace app\controllers;

use app\core\Response;
use app\services\CategoriesService;

class CategoriesController {

    public function __construct(private readonly CategoriesService $categoriesService) {}

    /**
     * Получение всех категорий
     *
     * @return Response
     */
    public function getAllAction(): Response {
        $categories = $this->categoriesService->getAll();

        return Response::jsonSuccess(data: $categories);
    }
}