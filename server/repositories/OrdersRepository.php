<?php

namespace app\repositories;

use app\core\Db;

class OrdersRepository {
    public function __construct(private readonly Db $db) {}

    /**
     * Получение всех заказов пользователя по его id
     *
     * @param int $userId
     * @return array
     */
    public function getByUserId(int $userId): array {
        return $this->db->fetchAll("SELECT 
                                                orders.*, 
                                                orders.id as order_id,
                                                products.*, 
                                                categories_types.name AS category, 
                                                categories_types.code as category_code, 
                                                brands.name as brand, 
                                                products_stocks.count as stock
                                        FROM orders 
                                            JOIN orders_products ON orders.id = orders_products.order_id 
                                            LEFT JOIN products ON orders_products.product_id = products.id
                                            JOIN categories_types ON products.category_type_id = categories_types.id
                                            LEFT JOIN brands ON products.brand_id = brands.id
                                            LEFT JOIN products_stocks ON products_stocks.product_id = products.id
                                        WHERE orders.user_id = ? 
                                        ORDER BY `orders`.`date` DESC",
            [$userId]);
    }
}