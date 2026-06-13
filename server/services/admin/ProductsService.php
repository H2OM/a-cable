<?php

namespace app\services\admin;

use app\core\enums\ResponseMessage;
use app\core\exceptions\ResponseException;
use app\core\Hydrator;
use app\core\Uploader;
use app\repositories\FiltersRepository;
use app\repositories\ProductsRepository;

/** Сервис для управления товарами */
readonly class ProductsService {
    public function __construct(
        private ProductsRepository $productsRepository,
        private FiltersRepository  $filtersRepository,
        private Uploader           $uploader,
        private Hydrator           $hydrator
    ) {}


    /**
     * Обновление товара
     *
     * @param array $data
     * @return string
     * @throws ResponseException
     */
    public function update(array $data): string {
        if(empty($data['id'])) {
            throw new ResponseException(ResponseMessage::ERROR_NOT_ENOUGH_DATA);
        }

        $id = $data['id'];
        $parsedData = $this->hydrator->decodeJson($data, [
            'related_products',
            'local_filters',
            'variations',
        ]);

        $related_products = $parsedData['related_products'];
        $localFilters     = $parsedData['local_filters'];
        $variations       = $parsedData['variations'];
        unset($parsedData['local_filters'], $parsedData['variations'], $parsedData['related_products']);

        $this->uploader->uploadFromFiles('new_images');
        $messages = $this->uploader->errors;

        if(!is_array($parsedData['images'])) {
            $parsedData['images'] = explode(',', $parsedData['images']);
        }

        $parsedData['images'] = [...$parsedData['images'], ...$this->uploader->savedFileNames];
        $parsedData['slider_images'] = implode(',', $parsedData['images']);
        unset($parsedData['images']);

        $updateResult = $this->productsRepository->update($parsedData);

        if(!$updateResult) {
            throw new ResponseException(ResponseMessage::ERROR_UPDATE);
        }

        if(!empty($variations)) {
            $variations[] = $id;

            if(!$this->pairVariations($variations, $variations)) {
                $messages[] = 'Не удалось привязать вариации!';
            }
        }

        if(!empty($related_products)) {
            $related_products[] = $id;

            if(!$this->pairRelated($related_products, $related_products)) {
                $messages[] = 'Не удалось добавить связанные товары!';
            }
        }

        if(!empty($localFilters)) {
            $formattedFilters = [];

            foreach ($localFilters as $value) {
                $formattedFilters[] = [
                    'filter_value_id' => $value['value_id'],
                    'product_id' => $id,
                ];
            }

            if(!$this->filtersRepository->insertFiltersValuesProducts($formattedFilters)) {
                $messages[] = 'Не удалось добавить характеристики товара!';
            }
        }

        return implode(PHP_EOL, $messages);
    }

    /**
     * Добавление новых товаров
     *
     * @param array $data
     * @return array|false
     */
    public function insert(array $data): array|false {
        return $this->productsRepository->insert($data);
    }

    /**
     * Добавление наличия товаров
     *
     * @param array $data
     * @return bool
     */
    public function insertStock(array $data): bool {
        return $this->productsRepository->insertStock($data);
    }

    /**
     * Удаление товаров по Id
     *
     * @param array $ids
     * @return bool
     */
    public function deleteByIds(array $ids): bool {
        return $this->productsRepository->deleteByIds($ids);
    }

    /**
     * Привязка вариаций к товару
     *
     * @param array $ids
     * @param array $variationsIds
     * @param bool $oneWay
     * @return bool
     */
    public function pairVariations(array $ids, array $variationsIds, bool $oneWay = false): bool {
        $data = [];

        foreach ($ids as $id) {
            foreach($variationsIds as $variationId) {
                $data[$id] = ['product_id' => $id, 'variation_id' => $variationId];

                if(!$oneWay) {
                    $data[$variationId] = ['product_id' => $variationId, 'variation_id' => $id];
                }
            }
        }

        return $this->productsRepository->pairVariations($data);
    }

    /**
     * Привязка связанных товаров
     *
     * @param array $ids
     * @param array $relatedIds
     * @param bool $oneWay
     * @return bool
     */
    public function pairRelated(array $ids, array $relatedIds, bool $oneWay = false): bool {
        $data = [];

        foreach ($ids as $id) {
            foreach($relatedIds as $relatedId) {
                $data[$id] = ['product_id' => $id, 'related_id' => $relatedId];

                if(!$oneWay) {
                    $data[$relatedId] = ['product_id' => $relatedId, 'related_id' => $id];
                }
            }
        }

        return $this->productsRepository->pairRelated($data);
    }

    /**
     * Присваивание товарам статуса хит продаж
     *
     * @param array $ids
     * @param bool $status
     * @return bool
     */
    public function changeHit(array $ids, bool $status): bool {
        return $this->productsRepository->changeHit($ids, $status);
    }
}