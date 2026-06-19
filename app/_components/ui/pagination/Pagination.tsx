'use client';

import usePagination from "@hooks/usePagination";

export default function Pagination({
    totalCount,
    defaultLimit = 30,
    limits = [30, 60, 90],
}: {
    totalCount: number;
    defaultLimit?: number;
    limits?: number[];
}) {
    const {page, limit, totalPages, setPage, setLimit} = usePagination(totalCount, defaultLimit);

    return (
        <div className="catalog__navigation">
            {page < totalPages &&
                <div className="btn btn_big catalog__navigation__btn"
                     onClick={() => setPage(page + 1)}>
                    Показать еще
                </div>
            }
            <div className="pagination">
                {page > 1 &&
                    <button className="pagination__btns _back" onClick={() => setPage(page - 1)}></button>
                }
                <div className="pagination__titles">
                    {page > 4 ?
                        <>
                            {(page - (6 - (totalPages - page))) < 3 ? null :
                                <>
                                    <div className="pagination__titles__tab" onClick={() => setPage(1)}>1</div>
                                    <div className="pagination__titles__dot">...</div>
                                </>
                            }
                            {totalPages - page >= 5 ?
                                <>
                                    <div className="pagination__titles__tab" onClick={() => setPage(page - 2)}>
                                        {page - 2}
                                    </div>
                                    <div className="pagination__titles__tab" onClick={() => setPage(page - 1)}>
                                        {page - 1}
                                    </div>
                                </>
                                :
                                Array.from({length: (6 - (totalPages - page))}).map((_, i) => {
                                    const tabPage = page - (6 - (totalPages - page)) + i;

                                    return (
                                        <div className="pagination__titles__tab"
                                             onClick={() => setPage(tabPage)}
                                             key={10 + i}>
                                            {tabPage}
                                        </div>
                                    )
                                })
                            }
                            <div className="pagination__titles__tab _active">{page}</div>
                        </>
                        :
                        Array.from({length: page}).map((_, i) => (
                            <div className={"pagination__titles__tab" + ((page === i + 1) ? " _active" : "")}
                                 onClick={() => page !== i + 1 && setPage(i + 1)}
                                 key={20 + i}>
                                {i + 1}
                            </div>
                        ))
                    }
                    {Array.from({length: ((totalPages - page) < 7 ? totalPages - page : 5)}).map((_, i) => (
                        <div className="pagination__titles__tab"
                             onClick={() => setPage(page + i + 1)}
                             key={30 + i}>
                            {page + i + 1}
                        </div>
                    ))}
                    {totalPages - page >= 7 &&
                        <>
                            <div className="pagination__titles__dot">...</div>
                            <div className="pagination__titles__tab"
                                 onClick={() => setPage(totalPages)}>
                                {totalPages}
                            </div>
                        </>
                    }
                </div>
                {page < totalPages &&
                    <button className="pagination__btns _next" onClick={() => setPage(page + 1)}></button>
                }
                <select className="pagination__limits" value={limit}
                        onChange={({currentTarget}) => {
                            setLimit(Number(currentTarget.value))
                        }}>
                    {limits.map(l => (
                        <option value={l} key={l} onClick={() => setLimit(l)}>{l}</option>
                    ))}
                </select>
            </div>
        </div>
    );
}