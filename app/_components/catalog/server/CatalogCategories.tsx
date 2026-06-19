import '../catalog.scss';
import {Category} from "@_types/categories";
import Link from "next/link";
import Image from "next/image";
import {categoriesAPI} from "@api";
import {redirect} from "next/navigation";

const IMAGES_URL = process.env.NEXT_PUBLIC_IMAGES_URL;

export default async function CatalogCategories() {
    const response = await categoriesAPI.getAll();

    if(!response.success) {
        redirect('/');
    }

    const categories: Category[] = response.data;

    return (
        <section className="catalog section">
            <div className="grid">
                <h1 className="title title_black _mb">Категории</h1>
                <div className="catalog__categories">
                    {categories.map((category: Category) => (
                        <Link href={`/catalog/${category.code}`} key={category.id}>
                            <Image
                                src={`${IMAGES_URL}/${category.image.trim()}`}
                                height={1000}
                                width={1000}
                                quality={100}
                                priority
                                alt={category.title}
                            />
                            <span className="describe__title">{category.title}</span>
                        </Link>
                    ))}
                </div>
            </div>
        </section>
    )
}