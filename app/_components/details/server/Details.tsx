import '../details.scss';
import Link from 'next/link';
import Image from "next/image";
import DetailsInteraction from '../client/DetailsInteraction';
import DetailsTabsNavigation from '../client/DetailsTabsNavigation';
import DetailsSlider from '@components/details/client/DetailsSlider';
import MiniSlider from "@ui/miniSlider/MiniSlider";
import {Product, ProductDetails} from "@_types/product";
import {Fragment} from "react";
import {notFound} from "next/navigation";
import {catalogAPI} from "@api";
import ClipboardCopy from "@ui/clipboardCopy/ClipboardCopy";

export default async function Details({params}: { params: Promise<{ id: string; }> }) {
    const {id} = await params;
    const response = await catalogAPI.getProductById(id);

    if (!response.success) {
        return notFound();
    }

    const {product, related}: {
        product: ProductDetails;
        related: Product[];
    } = response.data;

    console.log(product);
    console.log(related);

    return (
        <section className="Details section">
            <div className="grid">
                <h1 className="title title_black">{product.title} <span
                    className="title__type">{product.brand}</span>
                </h1>
                <div className="Details__split">
                    <div className="Details__split__content">
                        <div>
                            <div className="Details__split__content__price">
                                {product.price.toLocaleString('ru-RU', {
                                    style: 'currency',
                                    currency: 'RUB',
                                })}
                            </div>
                            <div className="describe__title" style={{display: 'flex', whiteSpace: 'nowrap'}}>
                                Артикул:&nbsp;<ClipboardCopy content={product.article}>{product.article}</ClipboardCopy>
                            </div>
                            <div className="describe__title" style={{display: 'flex', whiteSpace: 'nowrap'}}>
                                Категория:&nbsp;<Link href={`/catalog/${product.category_code}`}>{product.category}</Link>
                            </div>
                        </div>
                        <div>
                            {product.local_filters.map(filter => {
                                const productValue = filter.values.find(v => v.product_id === product.id);

                                // TODO Сделать нормальный красивый и правильный вывод А еще лучше если нет других
                                //  значений на выбор, то делать статические как артикул. Сделать что бы у остальных
                                //  товаров в фильтре тоже были ссылки на этот товар
                                return (
                                    <div className="Details__filters" key={filter.code}>
                                        {filter.name}:
                                        <div className="Details__filters__grid">
                                            {filter.values.map(value => {
                                                if(productValue?.code === value.code && product.id !== value.product_id) return;

                                                const key = `${value.code}-${value.product_id}`;
                                                const className = "Details__filters__filter";

                                                //TODO показать все (показать все варианты)

                                                return value.product_id === product.id ? (
                                                    <span className={className + ' _active'} key={key}>
                                                        {value.name}
                                                    </span>
                                                ) : (
                                                    <Link href={`/product/${value.product_id}`} className={className}
                                                          key={key}>
                                                        {value.name}
                                                    </Link>
                                                );
                                            })}
                                        </div>
                                    </div>
                                )
                            })}
                        </div>
                        {/*{product.colors.length !== 0 &&*/}
                        {/*    <>*/}
                        {/*        <div className="Details__split__content__title">Другие цвета:</div>*/}
                        {/*        <div className="Details__split__content__colors">*/}
                        {/*            {*/}
                        {/*                product.colors.map(color => {*/}
                        {/*                    const isCurrent = color.id === product.id;*/}

                        {/*                    const content = (*/}
                        {/*                        <Image*/}
                        {/*                            className={`Details__split__content__colors__type ${isCurrent ? "_active" : ""}`}*/}
                        {/*                            src={`/img/${color.image.trim()}`}*/}
                        {/*                            height={100}*/}
                        {/*                            width={110}*/}
                        {/*                            quality={100}*/}
                        {/*                            priority*/}
                        {/*                            alt="Цвет"*/}
                        {/*                            key={color.id}*/}
                        {/*                        />*/}
                        {/*                    );*/}

                        {/*                    return color.id === product.id*/}
                        {/*                        ? <Fragment key={color.id}>{content}</Fragment>*/}
                        {/*                        : <Link key={color.id} href={`/product/${color.id}`}>*/}
                        {/*                            {content}*/}
                        {/*                        </Link>;*/}
                        {/*                })*/}
                        {/*            }*/}
                        {/*        </div>*/}
                        {/*    </>*/}
                        {/*}*/}
                        {/*<DetailsInteraction sizes={product.size} productId={product.id}/>*/}
                    </div>
                    <DetailsSlider slides={product.slider_images.split(',')} mainImage={product.image}/>
                </div>
                <div className="Details__tabs">
                    <DetailsTabsNavigation>
                        <div className="Details__tabs__nav__tab _active" data-link={"Описание"}>
                            Описание
                        </div>
                        <div className="Details__tabs__nav__tab" data-link={"Товар"}>
                            О товаре
                        </div>
                        <div className="Details__tabs__nav__tab" data-link={"Отзывы"}>
                            Отзывы
                            {/* <span className="Details__tabs__nav__tab__value"> {Array.isArray(feedback) ? feedback.length : ""}</span> */}
                        </div>
                    </DetailsTabsNavigation>
                    <div className="Details__tabs__content">
                        <div className="Details__tabs__content__block _active"
                             data-link={"Описание"}>
                            {product.description}
                        </div>
                        <div className="Details__tabs__content__block" data-link={"Товар"}>
                            //Характеристики
                        </div>
                        <div className="Details__tabs__content__block" data-link={"Отзывы"}>
                            //Отзывы
                        </div>
                    </div>
                </div>
                {/*{related.length > 0 && <MiniSlider title={"Похожие товары"} products={related}/>}*/}
            </div>
        </section>
    )
}