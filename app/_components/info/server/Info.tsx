import '../info.scss';
import InfoForm from '@components/info/client/InfoForm';

export default function Info() {
    return (
        <section className="About section" id="About">
            {/*<div className="About__connect" id="Contacts">*/}
            {/*    <div className="grid">*/}
            {/*        <h2 className="title">Как с нами связаться?</h2>*/}
            {/*        <div className="About__describe About__describe_typethree">*/}
            {/*            <p>*/}
            {/*                Можете написать нам в <a href={contacts.socials.telegram} className="About__describe__link">Telegram*/}
            {/*                <Icons type={'telegram'} className={'About__describe__link__svg'}/>*/}
            {/*            </a> или <a href={contacts.socials.vk} className="About__describe__link">Vk*/}
            {/*                <Icons type={'vk'} className={'About__describe__link__svg'}/>*/}
            {/*            </a>.*/}
            {/*                <br/>*/}
            {/*                Наша почта - <span className="About__describe__link">{contacts.email}</span>.*/}
            {/*            </p>*/}
            {/*        </div>*/}
            {/*    </div>*/}
            {/*    <Icons type={'logo'} className="About__connect__logo"/>*/}
            {/*</div>*/}
            <div className="About__callback" id="Callback">
                <div className="grid">
                    <h1 className="title">Форма обратной связи</h1>
                    <div className="About__describe About__describe_typethree">Остались вопросы или нужна помощь
                        специалиста? Заполните форму и наш менеджер свяжется с вами.
                    </div>
                    <InfoForm/>
                </div>
            </div>
        </section>
    );
}