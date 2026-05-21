<?php

namespace app\services\admin;

/** Абстрактный сервис для управления парсерами */
abstract class ParserService {
    private const IMAGES_PATH = __DIR__ . "/../../../public/img/";

    /**
     * Парс из
     *
     * @param array $data
     * @return array
     */
    abstract protected function from(array $data): array;

    /**
     * Парс в текущую БД
     *
     * @param array $parsedProducts
     * @param int $categoryTypeId
     * @return bool
     */
    abstract protected function to(array $parsedProducts, int $categoryTypeId): bool;

    /**
     * Получение и сохранение изображения
     *
     * @param string $imageUrl
     * @param string $imageLocalName
     * @return bool
     */
    protected function getImage(string $imageUrl, string $imageLocalName): bool {
        $ch = curl_init($imageUrl);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
        curl_setopt($ch, CURLOPT_TIMEOUT, 30);
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

        $imageData = curl_exec($ch);
        $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
        curl_close($ch);

        if ($httpCode === 200 && $imageData !== false) {
            file_put_contents(self::IMAGES_PATH . $imageLocalName, $imageData);

            return true;
        } else {
            return false;
        }
    }
}