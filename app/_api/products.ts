import _FETCH from "@utils/_FETCH";

const API_URL = `${process.env.NEXT_PUBLIC_API_URL}/products`;

export const getById = async (id: number|string) => {
    return await _FETCH.request({url: `${API_URL}/get?id=${id}`});
}
