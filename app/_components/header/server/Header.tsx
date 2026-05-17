import Image from "next/image";
import Link from "next/link";
import '../header.scss';
import HeaderButtons from "@components/header/client/HeaderButtons";

export function Header() {
    return (
        <header className="Header" id="Main">
            <div className="Header__links">
                <div>
                    <Link className="Header__links__link" href={"/catalog"}>Каталог</Link>
                    <Link className="Header__links__link" href={"/catalog/cable-products/twisted-pair"}>Витая пара</Link>
                    <Link className="Header__links__link" href={"/catalog/cable-products/power-cable"}>Силовой кабель</Link>
                </div>
                <Link className="Header__links__link" href={"/info"}>О нас</Link>
            </div>
            <Link href={"/"}>
                <Image
                    src={"/png/Logomain.png"}
                    alt={"ЗДЕСЬ ДОЛЖЕН БЫЛ БЫТЬ ЛОГОТИП"}
                    className={"Header__logo"}
                    height={100}
                    width={250}
                    quality={100}
                    priority={true}
                />
            </Link>
            <HeaderButtons/>
        </header>
    );
}