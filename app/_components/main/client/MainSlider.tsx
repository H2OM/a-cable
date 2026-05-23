'use client';

import Image from "next/image";
import {useState} from "react";
import {SliderMain} from "@/_types/sliders";

export default function MainSlider({slides}: { slides: SliderMain[] }) {
    const [infoSlide, moveInfoSlide] = useState<number>(0);

    return (
        <div className="Slider__sections">
            <div className="Slider__sections__desc">
                <h2 className="title title_black">Новости</h2>
                <div>
                    <p className="title title_small">{slides[infoSlide].title}</p>
                    <p className="Slider__sections__desc__text">
                        {slides[infoSlide].text}
                    </p>
                </div>
                <div className="Slider__sections__desc__nav">
                    <div className="Slider__sections__desc__nav__arrows-wrap" onClick={() => {
                        if (infoSlide == 0) {
                            moveInfoSlide(slides.length - 1);
                        } else {
                            moveInfoSlide(slide => slide - 1);
                        }
                    }}>
                        <Image
                            src={"/png/arrow.png"}
                            alt={"back"}
                            className={"Slider__sections__desc__nav__arrows-wrap__arrows"}
                            width={0}
                            height={0}
                            sizes="100vw"
                            quality={100}
                            priority={true}
                        />
                    </div>
                    <div className="Slider__sections__desc__nav__bars">
                        {slides.map((slide, i) => {
                            return (
                                <div key={slide.id}
                                     className={"Slider__sections__desc__nav__bars__bar"
                                         + (i === infoSlide ? " Slider__sections__desc__nav__bars__bar_active" : "")
                                     }
                                     onClick={() => {
                                         moveInfoSlide(i);
                                     }}></div>
                            )
                        })}
                    </div>
                    <div className="Slider__sections__desc__nav__arrows-wrap" onClick={() => {
                        if (infoSlide === slides.length - 1) {
                            moveInfoSlide(0);
                        } else {
                            moveInfoSlide(slide => slide + 1);
                        }
                    }}>
                        <Image
                            src={"/png/arrow.png"}
                            alt={"next"}
                            className={"Slider__sections__desc__nav__arrows-wrap__arrows"}
                            width={0}
                            height={0}
                            sizes="100vw"
                            quality={100}
                            priority={true}
                        />
                    </div>
                </div>
            </div>
            <div className="Slider__sections__slide">
                <Image
                    src={"/img/" + slides[infoSlide].image.trim()}
                    alt={"КАРТИНКА К ТЕКСТУ"}
                    className={"Slider__sections__slide__img"}
                    height={1000}
                    width={1000}
                    quality={100}
                    priority={true}
                />
            </div>
        </div>
    );
}

