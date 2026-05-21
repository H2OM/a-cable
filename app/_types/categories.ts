import {FilterValues} from "@_types/filters";

export interface Category {
    id: number;
    title: string;
    code: string;
    image: string;
    types: FilterValues[];
}