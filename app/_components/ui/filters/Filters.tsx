'use client';

import './filters.scss';
import {useSearchParams} from "next/navigation";
import {useEffect, useState} from "react";
import DialogSwitch from "./DialogSwitch";
import DialogRange from "./DialogRange";
import DialogMulti from "./DialogMulti";
import {Filter, FilterModalOptions} from "@_types/filters";

export default function Filters({
    filters,
    categoryType,
    category = false
}: {
    filters: Filter[];
    category: boolean;
    categoryType?: string
}) {
    const searchParams = useSearchParams();
    const [showFullFilters, setShowFullFilters] = useState<boolean>(false);
    const [modalOptions, setModalOptions] = useState<FilterModalOptions>({
        modalType: "",
        cords: {
            x: "0px",
            y: "0px"
        },
        name: "",
        content: []
    });

    useEffect(() => {
        document.addEventListener('click', handleDocumentClose);
        window.addEventListener('resize', handleModalClose);

        return () => {
            document.removeEventListener('click', handleDocumentClose);
            window.removeEventListener('resize', handleModalClose);
        }
    }, []);

    const handleDocumentClose = (e: MouseEvent) => {
        const target = e.target as HTMLElement;

        if (!target.classList.contains('filters__tab') && !target.closest('.filters__tab__dialog')) {
            handleModalClose();
        }
    }

    const handleModalClose = () => {
        setModalOptions({...modalOptions, name: "", modalType: "", content: []});
    };

    const handleModalOpen = (target: HTMLDivElement, filter: Filter) => {
        setModalOptions({
            modalType: filter.type,
            name: filter.code,
            content: filter.values,
            cords: {
                x: `${target.offsetLeft}px`,
                y: `${target.offsetTop + target.offsetHeight}px`
            }
        });
    }

    return (
        <div className="filters">
            {filters.map((filter, i) => {
                if (filter.code === "category" && !category) return null;
                if(filter.code === "type" && categoryType) return null;

                if(i > 8 && !showFullFilters) return null;

                return (
                    <div className={"filters__tab"
                        + (searchParams.has(filter.code) ? " _selected" : "")
                        + (modalOptions.name == filter.code ? " _active" : "")}
                         key={filter.code + filter.name}
                         data-type={filter.type}
                         data-code={filter.code}
                         onClick={({currentTarget}) => {
                             filter.code === modalOptions.name
                                 ? handleModalClose()
                                 : handleModalOpen(currentTarget, filter);
                         }}>
                        {filter.name}
                    </div>
                );
            })}
            <button className={'btn' + (showFullFilters ? ' _outline' : '')}
                    onClick={()=> setShowFullFilters(prev => !prev)}
            >
                {showFullFilters ? 'Скрыть фильтры' : 'Показать все фильтры'}
            </button>
            {modalOptions.modalType === "switch" &&
                <DialogSwitch modalOptions={modalOptions} closeAction={handleModalClose}/>}
            {modalOptions.modalType === "range" &&
                <DialogRange modalOptions={modalOptions} closeAction={handleModalClose}/>}
            {modalOptions.modalType === "multi" &&
                <DialogMulti modalOptions={modalOptions} closeAction={handleModalClose}/>}
        </div>
    );
}