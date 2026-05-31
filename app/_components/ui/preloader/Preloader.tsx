'use client';

import "./preloader.scss";
import {useEffect, useState} from "react";
import Spinner from "@ui/spinner/Spinner";
import {usePathname} from "next/navigation";

export default function Preloader() {
    const [isContentLoaded, setContentLoaded] = useState(false);
    const pathname = usePathname();

    useEffect(() => {
        document.body.style.overflow = 'auto';

        setContentLoaded(true);
    }, [pathname]);

    return !isContentLoaded ? <div className="preloader"><Spinner className={'_white'}/></div> : null;
}