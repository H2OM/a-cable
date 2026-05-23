import Link from 'next/link';
import '../footer.scss';
import FooterForm from '../client/FooterForm';
import {Icons} from "@ui/icons/Icons";

export default function Footer() {

    return (
        <footer className="Footer">
            <div className="grid">
                <div className="Footer__block Footer__block_1">
                    <Link href={"/info#Callback"} className="Footer__link">Обратная связь</Link>
                    <Link href={"/info#Contacts"} className="Footer__link">Контакты</Link>
                    <Link href={"/"} className="Footer__logo">
                        <Icons type={'logo'}/>
                    </Link>
                </div>
                <div className="Footer__block Footer__block_2">
                    <Link href={"/info#Callback"} className="Footer__link">Тех. поддержка</Link>
                    <Link href={"/info#Contacts"} className="Footer__link">Соц. сети</Link>
                    <Link href={"/info#About"} className="Footer__link">О нас</Link>
                </div>
                <div className="Footer__block Footer__block_3">
                    <FooterForm/>
                </div>
            </div>
        </footer>
    )
}

