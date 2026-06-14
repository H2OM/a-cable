<?php

namespace app\controllers\admin;

use app\core\Request;
use app\core\Response;
use app\services\admin\FiltersService;

/** Контроллер для управления фильтрами */
readonly class FiltersController {
    public function __construct(private Request $request, private FiltersService $filtersService) {}

    /**
     * Получение всех фильтров
     *
     * @return Response
     */
    public function getAllAction(): Response {
        $page = (int)$this->request->get('page', 1);
        $limit = (int)$this->request->get('limit', 15);

        $filters = $this->filtersService->getAllByLimit($page, $limit);

        return Response::jsonSuccess(data: $filters);
    }

    /**
     * Получение кол-ва
     *
     * @return Response
     */
    public function getCountAction(): Response {
        $categoryId = $this->request->get('category_id');

        $count = $this->filtersService->getCount(categoryId: (int)$categoryId ?: null);

        return response::jsonSuccess(data: $count);
    }
}
