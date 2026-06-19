'use client';

import '../order.scss';
import '@components/personal/personal.scss';
import {useEffect, useState} from "react";
import {ordersAPI} from '@api';
import {useRouter} from "next/navigation";
import LoadScreen from "@ui/loadScreen/LoadScreen";
import Spinner from "@ui/spinner/Spinner";
import {Order} from "@_types/orders";
import {orderStatusMap} from "@/_constants/orderStatusMap";
import Link from "next/link";
import ClipboardCopy from "@ui/clipboardCopy/ClipboardCopy";
import Image from "next/image";

const IMAGES_URL = process.env.NEXT_PUBLIC_IMAGES_URL;

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
                        Основная информация
                    </div>
                    <div className="block-cart__body">
                        <ul className="dot-list">
                            <li>
                                <span>Заказ от:</span><span>{order.date}</span>
                            </li>
                            <li>
                                <span>Последняя дата изменения статуса:</span><span>{order.change_date}</span>
                            </li>
                            <li>
                                <span>Статус:</span>
                                <span>{orderStatusMap[order.status as keyof typeof orderStatusMap]}</span>
                            </li>
                            {order.comment !== '' &&
                                <li>
                                    <span>Комментарий</span><span>{order.comment}</span>
                                </li>
                            }
                        </ul>
                    </div>
                    <div className="block-cart__header" style={{marginTop: '15px'}}>
                        Доставка
                    </div>
                    <div className="block-cart__body">
                        <ul className="dot-list">
                            <li>
                                <span>Тип доставки:</span><span>{order.delivery}</span>
                            </li>
                            <li>
                                <span>Адресс доставки:</span><span>{order.delivery_address}</span>
                            </li>
                            <li>
                                <span>Дата доставки:</span><span>{order.delivery_date}</span>
                            </li>
                            <li>
                                <span>Адресс доставки:</span><span>{order.delivery_address}</span>
                            </li>
                        </ul>
                    </div>
                    <div className="block-cart__header" style={{marginTop: '15px'}}>
                        Оплата
                    </div>
                    <div className="block-cart__body">
                        <ul className="dot-list">
                            <li>
                                <span>Тип оплаты:</span><span>{order.payment}</span>
                            </li>
                            <li className="_big">
                                <span>Сумма заказа:</span>
                                <span>
                                    {order.price.toLocaleString('ru-RU', {
                                        style: 'currency',
                                        currency: 'RUB',
                                    })}
                                </span>
                            </li>
                            <li className="_big">
                                <span>Из них стоимость доставки:</span>
                                <span>
                                    {order.delivery_price.toLocaleString('ru-RU', {
                                        style: 'currency',
                                        currency: 'RUB',
                                    })}
                                </span>
                            </li>
                        </ul>
                    </div>
                    <div className="block-cart__header" style={{marginTop: '15px'}}>
                        Товары
                    </div>
                    <div className="block-cart__body">
                        {order.products.map(product => (
                            <div className="Personal__split__content__block__order__content__cart" key={product.id}>
                                <div className="Personal__split__content__block__order__content__cart__desc">
                                    <h2 className="Personal__split__content__block__order__content__cart__desc__price">
                                        {product.price.toLocaleString('ru-RU', {
                                            style: 'currency',
                                            currency: 'RUB',
                                        })}
                                        {product.price_old ?
                                            <span className="Personal__split__content__block__order__content__cart__desc__price _old">
                                                {product.price_old.toLocaleString('ru-RU', {
                                                    style: 'currency',
                                                    currency: 'RUB',
                                                })}
                                            </span>
                                            : null
                                        }
                                    </h2>
                                    <Link href={`/product/${product.id}`}>
                                        <div className="describe__title">
                                            {product.title}
                                        </div>
                                    </Link>
                                    <div className="describe__subtitle _start">
                                        Артикул:&nbsp;<ClipboardCopy content={product.article}/>
                                    </div>
                                </div>
                                <Link className="Personal__split__content__block__order__content__cart__desc__link"
                                      href={`/product/${product.id}`}>
                                    <Image
                                        src={`${IMAGES_URL}/${product.image.trim()}`}
                                        alt={"ОШИБКА ЗАГРУЗКИ ФОТОГРАФИИ"}
                                        className={"Personal__split__content__block__order__content__cart__image"}
                                        width={0}
                                        height={0}
                                        sizes="100vw"
                                        quality={100}
                                        priority={true}
                                    />
                                </Link>
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </section>
    );
}