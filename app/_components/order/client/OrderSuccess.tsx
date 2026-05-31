'use client';

import '../order.scss';
import {useEffect, useState} from "react";
import {ordersAPI} from '@api';
import {useRouter} from "next/navigation";
import LoadScreen from "@ui/loadScreen/LoadScreen";
import Spinner from "@ui/spinner/Spinner";
import {Order} from "@_types/orders";

export default function OrderSuccess({id}: { id: number }) {
    const [order, setOrder] = useState<Order | null>(null);
    const [isPending, setIsPending] = useState<boolean>(true);
    const router = useRouter();

    useEffect(() => {
        (async () => {
            setIsPending(true);

            const response = await ordersAPI.getOrder(id);

            setIsPending(false);

            if(response.success) {
                setOrder(response.data);

            } else {
                router.push('/');
            }
        })();
    }, [id]);

    if (!order) return <section className="order section"><LoadScreen><Spinner/></LoadScreen></section>

    return (
        <section className="order section">
            {isPending && <LoadScreen><Spinner/></LoadScreen>}
            <div className="grid">
                <h1 className="title">Заказ № {order.number ?? '...'}</h1>
                <div className="title _lite">Ваш заказ  успешно  оформлен! Детали заказа будут высланы вам на почту.</div>
                <br/>
                <div className="block-cart">
                    <div className="block-cart__header">
                        Основная информация:
                    </div>
                    <div className="block-cart__body" style={{
                        display: "flex",
                        flexDirection: 'column',
                        gap: '5px'
                    }}>
                        Тип доставки
                    </div>
                </div>
            </div>
        </section>
    );
}