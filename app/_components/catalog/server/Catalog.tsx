import {redirect} from "next/navigation";
import '../catalog.scss';
import Filters from "@ui/filters/Filters";
import Cart from "@ui/cart/Cart";
import {catalogAPI} from "@api";
import {Product} from "@_types/product";
import Fallback from "@ui/fallback/Fallback";
import {Filter} from "@_types/filters";
import normalizeParams from "@utils/normalizeParams";
import {SearchParams} from "@_types/common";
import Pagination from "@ui/pagination/Pagination";

export default async function Catalog({promiseParams, promiseSearchParams}: {
    promiseParams: Promise<{ category: string; type?:string }>
    promiseSearchParams: Promise<SearchParams>;
}) {
    const rawSearchParams: SearchParams = await promiseSearchParams;
    const params = await promiseParams;

    const searchParams = normalizeParams(rawSearchParams);

    searchParams.category = params.category;

    if(params.type) {
        searchParams.type = params.type;
    }

    const response = await catalogAPI.get(searchParams);

    if(!response.success) {
        redirect('/');
    }

    const {category_title, catalog, filters}: {
        category_title: string|null;
        catalog?: Product[];
        filters?: Filter[];
    } = response.data ?? {};

    if(!category_title) {
        redirect('/catalog');
    }

    const type = searchParams.type
        ? filters?.find(f => f.code === 'type')?.values.find(v => v.code === searchParams.type)
        : null;
    const title = type
        ? `${category_title} - ${type.name.toLowerCase()}`
        : category_title;

    return (
        <section className="catalog section">
            <div className="grid">
                {catalog &&
                    <>
                        <div className="catalog__title">
                            <h1 className="title title_black">{title}</h1>
                            <span className="title__count"> - {catalog.length}</span>
                        </div>
                        {(Object.keys(searchParams).length !== 0 || catalog.length > 0) && filters &&
                            <Filters filters={filters} category={title === ""} categoryType={params.type}/>
                        }
                        {catalog.length > 0 ?
                            <>
                                <div className="catalog__content">
                                    {catalog.map(product => {
                                        return (
                                            <Cart product={product} key={product.id}/>
                                        )
                                    })}
                                </div>
                                <Pagination totalCount={400}/>

                            </> :
                            <div className="title title_black" style={{marginTop: "20px", fontSize: "22px"}}>
                                Товаров не найдено
                            </div>
                        }
                    </>
                }
                {(!response.success || !catalog) && <Fallback message={response.message}/>}
            </div>
        </section>
    );
}