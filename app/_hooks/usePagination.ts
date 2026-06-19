'use client';

import {usePathname, useRouter, useSearchParams} from "next/navigation";
import {useMemo} from "react";

export default function usePagination(totalCount: number, defaultLimit = 30) {
    const router = useRouter();
    const pathname = usePathname();
    const searchParams = useSearchParams();

    const limit = useMemo(() => {
        const value = Number(searchParams.get('limit'));

        return value > 0 ? value : defaultLimit;
    }, [searchParams, defaultLimit]);

    const page = useMemo(() => {
        const value = Number(searchParams.get('page'));

        return value > 0 ? value : 1;
    }, [searchParams]);

    const totalPages = useMemo(() => {
        return Math.ceil(totalCount / limit);
    }, [totalCount, limit]);

    const setPage = (newPage: number) => {
        const params = new URLSearchParams(searchParams.toString());

        params.set('page', String(newPage));

        router.push(`${pathname}?${params.toString()}`);
    };

    const setLimit = (newLimit: number) => {
        const params = new URLSearchParams(searchParams.toString());

        params.set('limit', String(newLimit));
        params.set('page', '1');

        router.push(`${pathname}?${params.toString()}`);
    };

    return {
        page,
        limit,
        totalPages,
        setPage,
        setLimit,
    };
}
