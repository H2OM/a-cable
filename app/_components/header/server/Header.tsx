import Link from "next/link";
import '../header.scss';
import HeaderButtons from "@components/header/client/HeaderButtons";
import {Icons} from "@ui/icons/Icons";

export function Header() {
    return (
        <>
            <header className="header" id="Main">
                <div className="header__links">
                    <div>
                        <Link className="header__links__link" href={"/catalog"}>Каталог</Link>
                        <Link className="header__links__link" href={"/catalog/cable-products/twisted-pair"}>Витая пара</Link>
                        <Link className="header__links__link" href={"/catalog/cable-products/power-cable"}>Силовой кабель</Link>
                        <Link className="header__links__link" href={"/info"}>О нас</Link>
                    </div>
                </div>
                <Link href={"/"} className={"header__logo"}>
                    <Icons type={'logo'}/>
                </Link>
                <HeaderButtons/>
            </header>
            <div className="header__mount"></div>
        </>
    );
}