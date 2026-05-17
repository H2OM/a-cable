import {cache} from 'react';
import {Category} from "@_types/categories";

const categories: Category[] = [
    {
        id: 1,
        title: "Кабельная продукция",
        code: "cable-products",
        image: "cable.jpg",
    },
    {
        id: 2,
        title: "Освещение и светотехника",
        code: "lighting",
        image: "light.png",
    },
    {
        id: 3,
        title: "Электроустановочные изделия",
        code: "wiring-accessories",
        image: "electrical-installation.jpg",
    },
    {
        id: 4,
        title: "Инструменты",
        code: "tools",
        image: "7829c.1200x1000.jpg",
    },
    {
        id: 5,
        title: "Сетевое оборудование",
        code: "network-equipment",
        image: "dir-1260_r1_left.1200x1000.jpg",
    }
];

export const categoriesService = {
    getAll: cache((): Category[] => categories),
    getByCode: cache((code: string): Category | undefined => categories.find(cat => cat.code === code)),
    getById: cache((id: number): Category | undefined => categories.find(cat => cat.id === id)),
};
