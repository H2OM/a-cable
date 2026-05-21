<?php

namespace app\services\admin;

use app\repositories\parsers\AnlanRepository;
use Exception;

/** Парсер для сайта АнЛан */
class AnlanParserService {
    public function __construct(private readonly AnlanRepository $anlanRepository) {}

    /**
     * Взять товары из АнЛан
     *
     * @param array $data
     * @return array
     * @throws Exception
     */
    public function from(array $data): array {
        $products = $this->anlanRepository->getProducts($data['brand_id'], $data['categories_codes'], $data['limit']);

        file_put_contents(__DIR__ . '/data/products.json', json_encode(
            value: $products,
            flags: JSON_PRETTY_PRINT | JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE
        ));

        return $products;
    }

    /**
     * Загрузить в текущую базу товары из АнЛан
     *
     * @param array $data
     * @param int $categoryTypyId
     * @return bool
     */
    public function to(array $data, int $categoryTypyId): bool {
        $products = [];

        foreach ($data as $parse_product) {
            $product = [
//TODO
            ];
        }
    }
}