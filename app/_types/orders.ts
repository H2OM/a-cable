export interface DeliveryType {
    id: number;
    name: string;
    address: string | null;
    price: number;
}

export interface PaymentType {
    id: number;
    name: string;
}

export interface Order {
    id: number;
    payment_type_id: number;
    user_id: number;
    delivery_type_id: number;
    delivery_price: number;
    price: number;
    change_date: string;
    comment: string;
    date: string;
    delivery_address: string;
    delivery: string;
    delivery_date: string;
    number: string;
    payment: string;
    status: string;
    products: OrderProduct[];
}

export interface OrderProduct {
    id: number;
    count: number;
    price: number;
    price_old: number;
    title: string;
    article: string;
    image: string;
    unit: string;
}