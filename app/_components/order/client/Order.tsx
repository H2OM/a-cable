'use client';

import '../order.scss';
import {FormEvent, useEffect, useMemo, useState} from "react";
import useUser from "@hooks/useUser";
import OrderAuthBlock from "@components/order/client/OrderAuthBlock";
import {ordersAPI} from '@api';
import {DeliveryType, PaymentType} from "@_types/orders";
import {useBasket} from "@hooks/useBasket";
import {useRouter} from "next/navigation";
import LoadScreen from "@ui/loadScreen/LoadScreen";
import Spinner from "@ui/spinner/Spinner";

export default function Order() {
    const router = useRouter();
    const {user, isPending: isUserPending, manualSignIn} = useUser();
    const {basket, isPending: isBasketPending, getTotal, clear} = useBasket();
    const [isPending, setIsPending] = useState<boolean>(false);
    const [paymentTypes, setPaymentTypes] = useState<PaymentType[]>([]);
    const [deliveryTypes, setDeliveryTypes] = useState<DeliveryType[]>([]);
    const [selectedPaymentType, setSelectedPaymentType] = useState<PaymentType | null>(null);
    const [selectedDeliveryType, setSelectedDeliveryType] = useState<DeliveryType | null>(null);

    useEffect(() => {
        if ((basket.length === 0 && isBasketPending) || isPending) {
            return;

        } else if (basket.length === 0) {
            return router.push('/');
        }

        (async () => {
            setIsPending(true);

            const [responseDelivery, responsePayment] = await Promise.allSettled([
                ordersAPI.getDeliveryTypes(),
                ordersAPI.getPaymentTypes()
            ]);

            setIsPending(false);

            if (responseDelivery.status === "fulfilled" && responseDelivery.value.success) {
                setDeliveryTypes(responseDelivery.value.data);
            }

            if (responsePayment.status === "fulfilled" && responsePayment.value.success) {
                setPaymentTypes(responsePayment.value.data);
            }
        })();
    }, [basket]);

    const handleSubmit = async (e: FormEvent) => {
        e.preventDefault();

        const formData = new FormData(e.currentTarget as HTMLFormElement);
        const data = Object.fromEntries(formData);

        setIsPending(true);

        const date = new Date();

        const response = await ordersAPI.newOrder({
            user: user ? undefined : {
                first_name: String(data.first_name),
                second_name: String(data.second_name),
                phone: String(data.phone),
                age: Number(data.age),
                gender: String(data.gender) as "female" | "male",
                email: String(data.email)
            },
            payment_type_id: selectedPaymentType!.id,
            delivery_type_id: selectedDeliveryType!.id,
            delivery_price: selectedDeliveryType!.price,
            delivery_address: String(data.delivery_address),
            delivery_date: date.toLocaleDateString()
        });

        if (response.success) {
            clear(false);

            if (!user) {
                manualSignIn(response.data.user);
            }

            router.push(`/order/${response.data.order_id}`);
        } else {
            setIsPending(false);
        }
    }

    const total = useMemo(getTotal, [basket]);

    if (basket.length === 0) return <section className="order section"><LoadScreen><Spinner/></LoadScreen></section>

    return (
        <section className="order section">
            {isPending && <LoadScreen><Spinner/></LoadScreen>}
            <div className="grid">
                <h1 className="title">Оформление заказа</h1>
                <br/>
                {!user && !isUserPending && <OrderAuthBlock/>}
                <div className="block-cart">
                    <div className="block-cart__header title _lite" style={{margin: 0}}>Информация о доставке</div>
                    <form className="form"
                          style={{maxWidth: 'unset'}}
                          onSubmit={handleSubmit}>
                        <div className="block-cart__body form__split">
                            <div className="form__split__block">
                                <label className="form__label" htmlFor="delivery_type">
                                    Способ получения:
                                </label>
                                <select name="delivery_type"
                                        required
                                        value={selectedDeliveryType?.id || ''}
                                        onChange={({currentTarget}) => {
                                            setSelectedDeliveryType(deliveryTypes.find(t =>
                                                t.id === Number(currentTarget.value)) ?? null
                                            )
                                        }}>
                                    <option value={''} disabled={true}>Выберите способ доставки</option>
                                    {deliveryTypes.map(type => (
                                        <option key={type.id} value={type.id}>
                                            {type.name}
                                            {type.price ?
                                                ` | ${type.price.toLocaleString('ru-RU', {
                                                    style: 'currency',
                                                    currency: 'RUB',
                                                })}`
                                                : ''
                                            }
                                        </option>
                                    ))}
                                </select>
                            </div>
                            <div className="form__split__block">
                                <label className="form__label" htmlFor="delivery_address">
                                    Адрес доставки:
                                </label>
                                <input className="form__input"
                                       type="text"
                                       name="delivery_address"
                                       defaultValue={selectedDeliveryType?.address ?? ''}
                                       readOnly={Boolean(selectedDeliveryType?.address)}
                                       required
                                />
                            </div>
                        </div>
                        <div className="block-cart__body form__split">
                            <div className="form__split__block" style={{margin: 0}}>
                                <label className="form__label" htmlFor="payment_type">
                                    Способ оплаты:
                                </label>
                                <select name="payment_type"
                                        required
                                        value={selectedPaymentType?.id || ''}
                                        onChange={({currentTarget}) => {
                                            setSelectedPaymentType(paymentTypes.find(t =>
                                                t.id === Number(currentTarget.value)) ?? null
                                            )
                                        }}>
                                    <option value={''} disabled={true}>Выберите способ оплаты</option>
                                    {paymentTypes.map(type => (
                                        <option key={type.id} value={type.id}>{type.name}</option>
                                    ))}
                                </select>
                            </div>
                        </div>
                        <div className="block-cart__header">
                            <div className="title _lite">
                                Цена товаров:&nbsp;
                                {total.price.toLocaleString('ru-RU', {
                                    style: 'currency',
                                    currency: 'RUB',
                                })}
                            </div>
                            <div className="title _lite">
                                Цена доставки:&nbsp;
                                {(selectedDeliveryType?.price || '0').toLocaleString('ru-RU', {
                                    style: 'currency',
                                    currency: 'RUB',
                                })}
                            </div>
                            <div className="title _lite">
                                Общая стоимость заказа:&nbsp;
                                {(total.price + (selectedDeliveryType?.price || 0)).toLocaleString('ru-RU', {
                                    style: 'currency',
                                    currency: 'RUB',
                                })}
                            </div>
                        </div>
                        <div className="block-cart__body" style={{marginTop: '20px'}}>
                            <div style={{marginBottom: '5px'}}>
                                <label className="form__label">
                                    <input type="checkbox" name="agreement" required/>
                                    <a className="form__subinfo" target="blank" href={"agreement.html"}
                                       style={{marginLeft: "5px"}}>
                                        Согласие на обработку данных
                                    </a>
                                </label>
                            </div>
                            <div>
                                <label className="form__label">
                                    <input type="checkbox" name="agreement_email" required/>
                                    <a className="form__subinfo" target="blank" href={"agreement.html"}
                                       style={{marginLeft: "5px"}}>
                                        Согласие на получение рассылок по электронной почте
                                    </a>
                                </label>
                            </div>
                            <button className="btn form__btn" type="submit" disabled={isPending}>
                                Оформить заказ
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </section>
    );
}