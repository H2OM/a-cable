<?php

namespace app\services;

use app\core\Validator;
use app\repositories\OrdersRepository;
use Exception;

/** Сервис для получения информации по заказам */
class OrdersService {
    public function __construct(
        private readonly OrdersRepository $ordersRepository,
        private readonly Validator        $validator
    ) {}

    /**
     * Получение всех способов доставки
     *
     * @return array
     */
    public function getDeliveryTypes(): array {
        return $this->ordersRepository->getDeliveryTypes();
    }

    /**
     * Получение всех способов оплаты
     *
     * @return array
     */
    public function getPaymentTypes(): array {
        return $this->ordersRepository->getPaymentTypes();
    }

    /**
     * Создание нового заказа
     * **Обязательные поля:**
     *
     *                       [
     *                           'user_id' => int,
     *                           'delivery_type_id' => int,
     *                           'payment_type_id' => int,
     *                           'delivery_price' => int,
     *                           'delivery_date' => string,
     *                           'delivery_address' => string,
     *                           'products' => [['id' => int, 'price' => int, 'count' => int]]
     *                       ]
     *
     * @param array $data
     * @return int|false
     * @throws Exception
     */
    public function newOrder(array $data): int|false {
        $rules = [
            'user_id'          => ['required', 'integer'],
            'payment_type_id'  => ['required', 'integer'],
            'delivery_type_id' => ['required', 'integer'],
            'delivery_price'   => ['required', 'integer'],
            'products'         => ['required', 'array'],
            'delivery_date'    => ['required', 'text'],
            'delivery_address' => ['required', 'text'],
            'comment'          => ['text'],
        ];

        $validateData = $this->validator->validate($data, $rules);

        if(!$validateData) {
            throw new Exception($this->validator->formatErrors());
        }

        $validateData['number'] = substr(md5(uniqid(rand(), true)), 0, 13);
        $price = 0;
        $products = [];

        foreach ($validateData['products'] as $product) {
            $price = $price + $product['price'];
            $products[] = [
                'id'    => $product['id'],
                'count' => $product['count'],
            ];
        }

        $validateData['products'] = $products;
        $validateData['price']    = $price;

        return $this->ordersRepository->newOrder($validateData);
    }

    /**
     * Получение заказа
     *
     * @param int $id
     * @return array|null
     */
    public function getOrder(int $id): ?array {
        return $this->ordersRepository->getOrderById($id);
    }
}