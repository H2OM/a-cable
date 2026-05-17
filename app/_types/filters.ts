export type FilterType = 'switch' | 'multi' | 'range';

export interface Filter {
    code: string;
    name: string;
    type: FilterType;
    position: number;
    values: FilterValues[];
}

export interface FilterValues {
    id: string;
    code: string;
    name: string;
}

export interface FilterModalOptions {
    modalType: FilterType | "";
    cords: {
        x: string;
        y: string;
    };
    name: string;
    content: FilterValues[];
}
