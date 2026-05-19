'use client';

import {useEffect, useState} from "react";
import {useFavorites} from "@hooks/useFavorites";
import {useBasket} from "@hooks/useBasket";
import {Icons} from "@ui/icons/Icons";
import {ProductBasket} from "@_types/product";
import toast from "react-hot-toast";

export default function DetailsInteraction({productId, productStock}: { productId: number, productStock: number }) {
    const {toggle, isFavorite, isPending: isFavoritesPending} = useFavorites(productId);
    const {add, remove, isPending: isBasketPending, getItem, basket} = useBasket();
    const [currentProduct, setCurrentProduct] = useState<ProductBasket | undefined>(undefined);

    useEffect(() => {
        setCurrentProduct(getItem(productId));
    }, [productId, basket]);

    return (
        <div>
            {/*TODO доделать функционал - 'добавлено в корзину' и 'выбрать сколько добавить'*/}
            <div style={{display: "flex", flexDirection: "column", gap: '6px', minHeight: '86px'}}>
                <div className="Details__split__content__container">
                    {productStock > 0 ?
                        <button className="btn" disabled={isBasketPending} onClick={() => {
                            if(currentProduct && currentProduct.count >= currentProduct.stock) {
                                return toast.error('Больше в наличии нет!');
                            }

                            add(productId);
                        }}>
                            {currentProduct ? `Добавить еще (${currentProduct.count})` : 'В корзину'}
                        </button>
                        :
                        <button className="btn _transparent" disabled={true}>Нет в наличии</button>
                    }
                    <button className={"btn" + (isFavorite() ? ' _selected' : '')} disabled={isFavoritesPending}
                            onClick={() => toggle()}>
                        <Icons type={isFavorite() ? 'filedHeart' : 'unfiledHeart'}/>
                    </button>
                </div>
                {currentProduct &&
                    <button className="btn _outline _w-100" onClick={() => remove(productId)}>
                        Удалить из корзины
                    </button>
                }
            </div>
        </div>
    )
}