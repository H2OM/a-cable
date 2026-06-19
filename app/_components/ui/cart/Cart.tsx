'use client';

import './cart.scss';
import Image from "next/image";
import {Product} from "@_types/product";
import {Icons} from "@components/ui/icons/Icons";
import {useFavorites} from "@hooks/useFavorites";
import {useBasket} from "@hooks/useBasket";
import Link from "next/link";
import ClipboardCopy from "@ui/clipboardCopy/ClipboardCopy";
import toast from "react-hot-toast";

const IMAGES_URL = process.env.NEXT_PUBLIC_IMAGES_URL;

export default function Cart({product, isSlider = false}: { product: Product; isSlider?: boolean; }) {
    const {isFavorite, isPending, toggle} = useFavorites(product.id);
    const {add, getItem} = useBasket();

    return (
        <div className={"cart-wrap" + (isSlider ? " cart-wrap_slide" : "")}>
            <div className="cart"
                 onMouseEnter={({currentTarget}) => {
                     let target = currentTarget;

                     if (!target.classList.contains("cart")) target = target.closest(".cart")!;

                     target.classList.remove("_unactive");
                     target.classList.add("_active");
                 }}
                 onMouseLeave={({currentTarget}) => {
                     let target = currentTarget;

                     if (!target.classList.contains("cart")) target = target.closest(".cart")!;

                     target.classList.remove("_active");
                     target.classList.add("_unactive");
                 }}>
                <div className={"cart__heart" + (isPending ? ' _disabled' : '')} onClick={() => toggle()}>
                    <Icons type={isFavorite() ? 'filedHeart' : 'unfiledHeart'}/>
                </div>
                <Link href={`/product/${product.id}`}>
                    <Image
                        src={`${IMAGES_URL}/${product.image.trim()}`}
                        alt={"ОШИБКА ЗАГРУЗКИ ФОТОГРАФИИ"}
                        className={"cart__img"}
                        width={0}
                        height={0}
                        sizes="100vw"
                        quality={100}
                        priority={true}
                    />
                </Link>
                <div className="cart__desc">
                    <div className="cart__desc__price cart__desc__price_new">
                        {product.price.toLocaleString('ru-RU', {
                            style: 'currency',
                            currency: 'RUB',
                        })}&nbsp;
                        {product.price_old ?
                            <span className="cart__desc__price cart__desc__price_old">
                                {product.price_old.toLocaleString('ru-RU', {
                                    style: 'currency',
                                    currency: 'RUB',
                                })}
                            </span>
                            : null
                        }
                    </div>
                    <Link href={`/catalog/${product.category_code}`} className="cart__desc__sub-title">
                        {product.category}
                    </Link>
                    <Link href={`/product/${product.id}`} className="cart__desc__title">
                        {product.title}
                    </Link>
                    <h3 className="cart__desc__sub-title"
                        style={{display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: '20px'}}>
                        {product.brand}
                        <ClipboardCopy content={product.article}/>
                    </h3>
                    {/*TODO слайдер вариаций*/}
                    <div className="variations">
                        {product.variations.map(variation => (
                            <Link href={`/product/${variation.id}`} key={variation.id}>
                                <Image
                                    src={`${IMAGES_URL}/${variation.image.trim()}`}
                                    alt={"ОШИБКА ЗАГРУЗКИ ФОТОГРАФИИ"}
                                    width={0}
                                    height={0}
                                    sizes="100vw"
                                    quality={100}
                                    priority={true}
                                />
                            </Link>
                        ))}
                    </div>
                    <div className={"stock" + (product.stock > 0 ? ' _in-stock' : ' _out-stock')}>
                        {product.stock > 0 ?
                            `В наличии: ${product.stock} ${product.unit}`
                            : 'Нет в наличии'
                        }
                    </div>
                </div>
                {product.stock > 0 ?
                    <button className="btn" onClick={() => {
                        if((getItem(product.id)?.count ?? 0) >= product.stock)
                            return toast.error('Больше в наличии нет!');

                        add(product.id)
                    }}>
                        В корзину
                    </button>
                    :
                    <button className="btn _transparent" disabled={true}>
                        Товар закончился
                    </button>
                }
            </div>
        </div>
    );
}