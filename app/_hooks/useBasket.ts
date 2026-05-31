import {useContext} from "react";
import BasketContext from "@providers/BasketProvider";
import {ProviderBasket} from "@_types/providers";

export function useBasket() {
    const context = useContext<ProviderBasket | null>(BasketContext);

    if (!context) {
        throw new Error('Basket provider is missing');
    }

    const getTotal = () => {
        return context.basket.reduce((acc, product) => ({
            price: acc.price + product.price * product.count,
            count: acc.count + product.count
        }), {price: 0, count: 0});
    };

    return {
        ...context,
        getTotal,
        getItem: (id: number) =>
            context.basket.find(p => p.id === id)
    };
}
