'use client';

import {ProductBasket} from "@_types/product";
import {useFavorites} from "@hooks/useFavorites";
import {useBasket} from "@hooks/useBasket";
import {Icons} from "@ui/icons/Icons";
import Link from "next/link";
import Image from "next/image";
import ClipboardCopy from "@ui/clipboardCopy/ClipboardCopy";
import toast from "react-hot-toast";

const IMAGES_URL = process.env.NEXT_PUBLIC_IMAGES_URL;

export default function BasketCart({product}: { product: ProductBasket }) {
    const {isFavorite, toggle} = useFavorites(product.id);
    const {add, decrement, remove} = useBasket();

    return (
        <div className="Basket__split__content__cart">
            <div className="Basket__split__content__cart__desc">
                <h2 className="Basket__split__content__cart__desc__price">
                    {product.price.toLocaleString('ru-RU', {
                        style: 'currency',
                        currency: 'RUB',
                    })}
                </h2>
                <div className="describe__title">
                    {product.title}
                </div>
                <div className="describe__title">{product.brand}</div>
                <div className="describe__subtitle">
                    Артикул:&nbsp;<ClipboardCopy content={product.article}/>
                </div>
                <div className="describe__subtitle">
                    Категория: <Link href={`/catalog/${product.category_code}`}>{product.category}</Link>
                </div>
            </div>
            <div className="Basket__split__content__cart__options">
                <button
                    className={"btn Basket__split__content__cart__options__btn" + (isFavorite() ? '' : '  _outline')}
                    onClick={() => toggle()}>
                    <Icons type={isFavorite() ? 'filedHeart' : 'unfiledHeart'}
                           className={"Basket__split__content__cart__options__btn__svg"}
                    />
                </button>
                <div className="Basket__split__content__cart__options__value">
                    <button className="Basket__split__content__cart__options__value__btn"
                            onClick={() => decrement(product.id)}>
                        <Icons type={'dash'} className={'Basket__split__content__cart__options__value__btn__svg'}/>
                    </button>
                    <span className="Basket__split__content__cart__options__value__show">{product.count}</span>
                    <button className="Basket__split__content__cart__options__value__btn"
                            onClick={() => {
                                if(product.count >= product.stock) return toast.error('Больше в наличии нет!');
                                add(product.id)
                            }}>
                        <Icons type={'plus'} className={'Basket__split__content__cart__options__value__btn__svg'}/>
                    </button>
                </div>
                <button className="btn Basket__split__content__cart__options__remove"
                        onClick={() => remove(product.id)}>
                    <Icons type={'cross'} className={'Basket__split__content__cart__options__remove__svg'}/>
                </button>
            </div>
            <Link href={`/product/${product.id}`}>
                <Image
                    className="Basket__split__content__cart__image"
                    src={`${IMAGES_URL}/${product.image.trim()}`}
                    height={160}
                    width={160}
                    quality={100}
                    priority={true}
                    alt="изображение"
                />
            </Link>
        </div>
    );
}