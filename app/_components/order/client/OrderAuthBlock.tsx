'use client';

import MaskInput from "@ui/maskInput/MaskInput";

export default function OrderAuthBlock() {
    return (
    <div className="cart">
        <div className="cart__header title _lite" style={{margin: 0}}>
            Персональные данные
        </div>
        <div className="cart__body form__split">
            <div className="form__split__block">
                <label className="form__label" htmlFor="first_name">Имя:</label>
                <input className="form__input" type="text" name="first_name" required/>
                <label className="form__label" htmlFor="email">Электронная почта:</label>
                <input className="form__input" type="email" name="email" required/>
                <label className="form__label" htmlFor="age">Возраст:</label>
                <input className="form__input" type="number" name="age" required/>
            </div>
            <div className="form__split__block">
                <label className="form__label" htmlFor="second_name">Фамилия:</label>
                <input className="form__input" type="text" name="second_name" required/>
                <label className="form__label" htmlFor="number">Номер телефона:</label>
                <MaskInput className={"form__input"} name={"phone"} required/>
                <label className="form__label" htmlFor="genders">Пол:</label>
                <div className="form__subBlock" id="genders">
                    <input className="form__input _radio"
                           type="radio" name="gender" id="female" value="female" required/>
                    <label className="form__label _radio"
                           htmlFor="female">Женский</label>
                    <input className="form__input _radio"
                           type="radio" name="gender" id="male" value="male" required/>
                    <label className="form__label _radio"
                           htmlFor="male">Мужской</label>
                </div>
            </div>
        </div>
    </div>
    );
}