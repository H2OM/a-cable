import '../details.scss';
import Link from 'next/link';
import DetailsInteraction from '../client/DetailsInteraction';
import DetailsTabsNavigation from '../client/DetailsTabsNavigation';
import DetailsSlider from '@components/details/client/DetailsSlider';
import MiniSlider from "@ui/miniSlider/MiniSlider";
import {ProductLocalFilter, Product, ProductDetails, ProductLocalFilters} from "@_types/product";
import {notFound} from "next/navigation";
import {catalogAPI} from "@api";
import ClipboardCopy from "@ui/clipboardCopy/ClipboardCopy";
import ClientImage from "@ui/clientImage/ClientImage";

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

    const staticFilters: ({ filter_name: string } & ProductLocalFilter)[] = [];
    const dynamicFilters: ProductLocalFilters[] = [];

    product.variations.push({id: product.id, image: product.image});

    product.local_filters.forEach(filter => {
        const productValue = filter.values.find(v => v.product_id === product.id);
        const uniqueCode = new Set<string>();

        const uniqueValues = filter.values.filter(value => {
            if (uniqueCode.has(value.code) || (value.code === productValue?.code && value.product_id !== product.id)) {
                return false;
            }

            uniqueCode.add(value.code);

            return true;
        });

        if (uniqueValues.length > 1) {
            dynamicFilters.push({...filter, values: uniqueValues});

        } else if (productValue) {
            staticFilters.push({filter_name: filter.name, ...productValue});
        }
    });

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
                            <div className="describe__title">
                                Артикул:&nbsp;<ClipboardCopy content={product.article}>{product.article}</ClipboardCopy>
                            </div>
                            <div className="describe__title">
                                Категория:&nbsp;<Link
                                href={`/catalog/${product.category_code}`}>{product.category}</Link>
                            </div>
                            {staticFilters.map(filter => (
                                <div className="describe__title" key={filter.code + filter.filter_name}>
                                    {filter.filter_name}:&nbsp;<span>{filter.name}</span>
                                </div>
                            ))}
                        </div>
                        <div>
                            {dynamicFilters.map(filter => {
                                return (
                                    <div className="Details__block" key={filter.code}>
                                        {filter.name}:
                                        <div className="Details__block__grid">
                                            {filter.values.map(value => {
                                                const key = `${value.code}-${value.product_id}`;
                                                const className = "Details__block__filter";

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
                        {/*TODO показать все (показать все варианты)*/}
                        {product.variations.length > 1 &&
                            <div className="Details__block">
                                Варианты:
                                <div className="Details__block__grid variations _big">
                                    {product.variations
                                        .sort((a, b) => a.id - b.id)
                                        .map(variation => {
                                            const img = (
                                                <ClientImage
                                                    src={`/img/${variation.image.trim()}`}
                                                    alt={String(variation.id)}
                                                    width={500}
                                                    height={500}
                                                    quality={100}
                                                />
                                            );

                                            return variation.id === product.id ? (
                                                <span className="_active" key={variation.id}>
                                                    {img}
                                                </span>
                                            ) : (
                                                <Link href={`/product/${variation.id}`} key={variation.id}>
                                                    {img}
                                                </Link>
                                            );
                                        })
                                    }
                                </div>
                            </div>
                        }
                        <div>
                            <div className={"stock" + (product.stock > 0 ? ' _in-stock' : ' _out-stock')}>
                                {product.stock > 0 ?
                                    `В наличии: ${product.stock} ${product.unit}`
                                    : 'Нет в наличии'
                                }
                            </div>
                            <DetailsInteraction productId={product.id} productStock={product.stock ?? 0}/>
                        </div>
                    </div>
                    <DetailsSlider slides={product.slider_images.split(',')} mainImage={product.image}/>
                </div>
                <div className="Details__tabs">
                    <DetailsTabsNavigation>
                        <div className="Details__tabs__nav__tab _active" data-link={"Описание"}>
                            Описание
                        </div>
                        <div className="Details__tabs__nav__tab" data-link={"Товар"}>
                            Характеристики
                            {/*TODO характеристики*/}
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
                {related.length > 0 && <MiniSlider title={"Похожие товары"} products={related}/>}
            </div>
        </section>
    )
}