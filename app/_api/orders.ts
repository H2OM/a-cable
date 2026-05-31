import _FETCH from "@/_utils/_FETCH";
import {User} from "@_types/user";

const API_URL = `${process.env.NEXT_PUBLIC_API_URL}/orders`;

export const getDeliveryTypes = async () => {
    return await _FETCH.request({url: `${API_URL}/get-delivery-types`});
}

export const getPaymentTypes = async () => {
    return await _FETCH.request({url: `${API_URL}/get-payment-types`});
}

export const getOrder = async (id: number) => {
    return await _FETCH.request({url: `${API_URL}/get?id=${id}`});
}

export const newOrder = async (data: {
    user?: Omit<User, 'id'>,
    payment_type_id: number,
    delivery_type_id: number,
    delivery_address: string,
    delivery_price: number,
    delivery_date: string
}) => {
    return await _FETCH.progressTrackingRequest({
        url: `${API_URL}/new`,
        options: {
            method: "POST",
            body: JSON.stringify(data)
        },
        loading: 'Оформление заказа...'
    });
}