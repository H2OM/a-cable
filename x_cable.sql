-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Май 21 2026 г., 02:19
-- Версия сервера: 8.0.30
-- Версия PHP: 8.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `x_cable`
--

-- --------------------------------------------------------

--
-- Структура таблицы `admins`
--

CREATE TABLE `admins` (
  `id` int UNSIGNED NOT NULL,
  `role_id` int UNSIGNED NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `login` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `last_login` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `admins`
--

INSERT INTO `admins` (`id`, `role_id`, `name`, `email`, `login`, `password`, `last_login`) VALUES
(1, 1, 'Администратор', 'admin@admin.admin', 'admin', '$2y$10$Zt5JHqRP3RqIuIiyK/XgD.munQ1/vssnmQQ5pieS2hl/4jojAqV2i', '2026-05-20 14:25:34');

-- --------------------------------------------------------

--
-- Структура таблицы `admins_roles`
--

CREATE TABLE `admins_roles` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `admins_roles`
--

INSERT INTO `admins_roles` (`id`, `name`, `code`) VALUES
(1, 'Супер админ', 'superadmin'),
(2, 'Менеджер', 'manager');

-- --------------------------------------------------------

--
-- Структура таблицы `admins_roles_permissions`
--

CREATE TABLE `admins_roles_permissions` (
  `role_id` int UNSIGNED NOT NULL,
  `permission_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `admins_roles_permissions`
--

INSERT INTO `admins_roles_permissions` (`role_id`, `permission_id`) VALUES
(1, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 8),
(2, 9);

-- --------------------------------------------------------

--
-- Структура таблицы `brands`
--

CREATE TABLE `brands` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `brands`
--

INSERT INTO `brands` (`id`, `name`, `code`) VALUES
(1, 'Cabeus', 'cabeus'),
(2, 'DataCable', 'datacable'),
(3, 'Rexant', 'rexant');

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `title`, `code`, `image`) VALUES
(1, 'кабельная продукция', 'cable-products', ' cable.jpg'),
(2, 'Освещение и светотехника', 'lighting', 'light.png'),
(3, 'Электроустановочные изделия', 'wiring-accessories', 'electrical-installation.jpg'),
(4, 'Инструменты', 'tools', '7829c.1200x1000.jpg'),
(5, 'Сетевое оборудование', 'network-equipment', 'dir-1260_r1_left.1200x1000.jpg');

-- --------------------------------------------------------

--
-- Структура таблицы `categories_filters`
--

CREATE TABLE `categories_filters` (
  `category_id` int UNSIGNED NOT NULL,
  `filter_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Привязывание фильтров к категории';

--
-- Дамп данных таблицы `categories_filters`
--

INSERT INTO `categories_filters` (`category_id`, `filter_id`) VALUES
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(1, 15);

-- --------------------------------------------------------

--
-- Структура таблицы `categories_types`
--

CREATE TABLE `categories_types` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `category_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `categories_types`
--

INSERT INTO `categories_types` (`id`, `name`, `code`, `category_id`) VALUES
(1, 'Силовой кабель', 'power-cable', 1),
(2, 'Витая пара', 'twisted-pair', 1),
(3, 'Телефонный кабель', 'telephone-cable', 1),
(4, 'Коаксиальный кабель', 'coaxial-cable', 1),
(5, 'Оптоволоконный кабель', 'fiber-optic-cable', 1),
(6, 'Ретро провод', 'retro-wire', 1),
(7, 'Кабель для видеонаблюдения', 'cctv-cable', 1),
(8, 'Акустический кабель', 'speaker-cable', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `favorites`
--

CREATE TABLE `favorites` (
  `user_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `favorites`
--

INSERT INTO `favorites` (`user_id`, `product_id`) VALUES
(16, 20),
(16, 21),
(16, 23);

-- --------------------------------------------------------

--
-- Структура таблицы `feedbacks`
--

CREATE TABLE `feedbacks` (
  `id` int UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `mark` enum('1','2','3','4','5') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `filters`
--

CREATE TABLE `filters` (
  `id` int UNSIGNED NOT NULL,
  `filter` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('switch','multi','range','') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `position` tinyint UNSIGNED NOT NULL DEFAULT '127'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `filters`
--

INSERT INTO `filters` (`id`, `filter`, `code`, `type`, `position`) VALUES
(1, 'Сортировка', 'sort', 'switch', 1),
(2, 'Скидка', 'sale', 'switch', 254),
(3, 'Тип', 'type', 'multi', 2),
(4, 'Бренд', 'brand', 'multi', 3),
(5, 'Цена', 'price', 'range', 255),
(7, 'Цвет', 'color', 'multi', 127),
(8, 'Длинна', 'length', 'multi', 127),
(9, 'Кол-во пар', 'pairs_count', 'multi', 127),
(10, 'Исполнение', 'perfomance', 'multi', 127),
(11, 'Кол-во проводников', 'cores_count', 'multi', 127),
(12, 'Сечение кабеля', 'cable_section', 'multi', 127),
(13, 'Материал', 'material', 'multi', 127),
(14, 'Номинальное напряжение', 'rated_voltage', 'multi', 127),
(15, 'Скорость передачи данных', 'data_rate', 'switch', 127);

-- --------------------------------------------------------

--
-- Структура таблицы `filters_values`
--

CREATE TABLE `filters_values` (
  `id` int UNSIGNED NOT NULL,
  `value` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(28) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `filter_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `filters_values`
--

INSERT INTO `filters_values` (`id`, `value`, `code`, `filter_id`) VALUES
(77, '2.5 мм^2', '2d5mm', 12),
(81, '3', '3', 11),
(73, '305 м', '305m', 8),
(74, '4', '4', 9),
(76, '4', '4', 11),
(78, '50 м', '50m', 8),
(80, '660 В', '660v', 14),
(57, 'Бежевый', 'beige', 7),
(55, 'Белый', 'white', 7),
(58, 'Бордовый', 'vinous', 7),
(82, 'ВВГ-Пнг(А)-LS', 'vvg-png-a-ls', 10),
(59, 'Голубой', 'blue', 7),
(4, 'Да', 'yes', 2),
(83, 'До 0,01 Гбит/с', '001gbits', 15),
(84, 'До 0,1 Гбит/с', '01gbits', 15),
(85, 'До 1 Гбит/с', '1gbits', 15),
(88, 'До 10 Гбит/с', '10gbits', 15),
(86, 'До 2.5 Гбит/с', '2d5gbits', 15),
(89, 'До 40 Гбит/с', '40gbits', 15),
(87, 'До 5 Гбит/с', '5gbits', 15),
(63, 'Зеленый', 'green', 7),
(79, 'Медь', 'copper', 13),
(60, 'Мультиколор', 'multicolor', 7),
(75, 'нг(А)-HF', 'ng-a-hf', 10),
(5, 'Нет', 'no', 2),
(61, 'Оранжевый', 'orange', 7),
(1, 'По возрастанию цены', 'low-to-high', 1),
(3, 'По популярности', 'by-popular', 1),
(2, 'По убыванию цены', 'high-to-low', 1),
(62, 'Розовый', 'pink', 7),
(72, 'Серый', 'gray', 7),
(56, 'Черный', 'black', 7);

-- --------------------------------------------------------

--
-- Структура таблицы `filters_values_products`
--

CREATE TABLE `filters_values_products` (
  `filter_value_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `filters_values_products`
--

INSERT INTO `filters_values_products` (`filter_value_id`, `product_id`) VALUES
(72, 20),
(73, 20),
(74, 20),
(75, 20),
(76, 20),
(86, 20),
(61, 21),
(73, 21),
(74, 21),
(75, 21),
(76, 21),
(86, 21),
(62, 22),
(74, 22),
(75, 22),
(76, 22),
(78, 22),
(86, 22),
(56, 23),
(77, 23),
(78, 23),
(79, 23),
(80, 23),
(81, 23),
(82, 23);

-- --------------------------------------------------------

--
-- Структура таблицы `news`
--

CREATE TABLE `news` (
  `id` int UNSIGNED NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `news`
--

INSERT INTO `news` (`id`, `text`, `image`) VALUES
(4, 'Новая модель Reebok - Zig Kinetica! Zig Kinetica – модель с беговой историей, ставшая иконой уличного стиля. Сегодня технологии Reebok на страже повседневного комфорта. Дополнительные свойства: Зигзагообразный ТПУ каркас ZIG ENERGY SHELL обеспечивающий стабилизацию, направляя и возвращая кинетическую энергию. Комбинация пеноматериалов FLOATRIDE ENERGY и FLOATRIDE FUEL в промежуточной подошве обеспечивает легкую и отзывчивую амортизацию, а также гасит ударные нагрузки. Дышащий комбинированный верх выполнен с использованием двухслойной сетки и обеспечивает превосходную циркуляцию воздуха. Инновационные резиновые полоски ZIG ENERGY BANDS на подметке сжимаются и разжимаются, усиливая возврат энергии с каждым шагом.', 'img/info1.jpg'),
(5, 'Кроссовки PUMA RS-Z LTH Trainers. Футуристический внешний вид модели PUMA RS-Z LTH Trainers сочетается с продуманными технологическим наполнением. Верх изготовлен из кожи и отвечает за внешний вид и долговечность пары. Подошва с технологией Running System — мягкий вспененный материал IMEVA и формованная стелька снижают ударные нагрузки и обеспечивают ощущение легкости даже на длинных дистанциях. Знаменитые полосы PUMA Formstrip выделяются по структуре, дополняя многослойную конструкцию верха.', 'png/info3.png'),
(6, 'Зарегистрируйтесь на нашем сайте и получите бонус в виде промокода на первый заказ.', 'png/info2.png'),
(7, 'Новый интернет-магазин обуви - Shoes!', 'png/info4.png');

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` int UNSIGNED NOT NULL,
  `number` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('0','1','2','3') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `user_id` int UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `change_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery_date` date NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `orders_products`
--

CREATE TABLE `orders_products` (
  `order_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `permissions`
--

CREATE TABLE `permissions` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `code` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `permissions`
--

INSERT INTO `permissions` (`id`, `name`, `code`) VALUES
(1, 'Полный доступ', '*'),
(2, 'Доступ к товарам', 'products'),
(3, 'Удаление товаров', 'products.delete'),
(4, 'Редактирование товаров', 'products.edit'),
(5, 'Добавление товаров', 'products.add'),
(6, 'Доступ к пользователям', 'users'),
(7, 'Удаление пользователей', 'users.delete'),
(8, 'Редактирование пользователей', 'users.edit'),
(9, 'Добавление пользователей', 'users.add');

-- --------------------------------------------------------

--
-- Структура таблицы `products`
--

CREATE TABLE `products` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `brand_id` int UNSIGNED NOT NULL,
  `category_type_id` int UNSIGNED DEFAULT NULL,
  `article` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `price` float NOT NULL DEFAULT '0',
  `price_old` float NOT NULL DEFAULT '0',
  `unit` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Untitled.jpg',
  `slider_images` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'example.jpg,example2.jpg,example3.jpg...',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `hit` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `products`
--

INSERT INTO `products` (`id`, `title`, `brand_id`, `category_type_id`, `article`, `price`, `price_old`, `unit`, `image`, `slider_images`, `description`, `hit`) VALUES
(20, 'Кабель витая пара UTP (U/UTP), категория 5e, 4 пары (24 AWG), одножильный, серый, LSZH, нг(А)-HF, (305 м)', 1, 2, 'UTP-4P-Cat.5e-SOLID-LSZH-GY', 17123.2, 0, 'шт.', '9776c-other.1200x1000.jpg', '9776c-other.1200x1000.jpg,9776c.1200x1000.jpg,9776c.3.1200x1000.jpg', 'Четырехпарный кабель категории 5e на основе витой пары предназначен для использования в системах передачи данных со скоростью до 2.5 Гбит/c. Кабель выполнен в неэкранированном исполнении U/UTP и предназначен для прокладки внутри зданий. Диаметр проводников составляет 0,50 мм (24 AWG). Внешняя оболочка выполнена из не распространяющего горение LSZH-компаунда, малодымного и не выделяющего ядовитых соединений в процессе горения, исполнение нг(А)-HF. На внешней оболочке кабеля нанесены метровые метки длины кабеля.\r\nКабель обладает отличными характеристиками при разумной цене, что делает его оптимальным вариантом для построения сетей в проектах, в том числе где требуется гарантийная системная поддержка. Кабель поставляется в картонной коробке «easy-pull box».', '1'),
(21, 'Кабель витая пара UTP (U/UTP), категория 5e, 4 пары (24 AWG), одножильный, оранжевый, LSZH, нг(А)-HF, (305 м)', 1, 2, 'UTP-4P-Cat.5e-SOLID-LSZH', 17123.2, 0, 'шт.', 'utp-4p-cat5e-solid-lszh_1.1200x1000.jpg', 'utp-4p-cat5e-solid-lszh_1.1200x1000.jpg,7170c.1200x1000.jpg,7170c.3.1200x1000.jpg', 'Четырехпарный кабель категории 5e на основе витой пары предназначен для использования в системах передачи данных со скоростью до 2.5 Гбит/c. Кабель выполнен в неэкранированном исполнении U/UTP и предназначен для прокладки внутри зданий. Диаметр проводников составляет 0,50 мм (24 AWG). Внешняя оболочка выполнена из не распространяющего горение LSZH-компаунда, малодымного и не выделяющего ядовитых соединений в процессе горения, исполнение нг(А)-HF. На внешней оболочке кабеля нанесены метровые метки длины кабеля.\r\nКабель обладает отличными характеристиками при разумной цене, что делает его оптимальным вариантом для построения сетей в проектах, в том числе где требуется гарантийная системная поддержка. Кабель поставляется в картонной коробке «easy-pull box».', '1'),
(22, 'Кабель витая пара UTP (U/UTP), категория 5e, 4 пары (24 AWG), одножильный, оранжевый, LSZH, нг(А)-HF, (305 м)', 1, 2, 'UTP-4P-Cat.5e-SOLID-LSZH_pink', 17123.2, 0, 'шт.', 'utp-4p-cat5e-solid-lszh_1.1200x1000.jpg', 'utp-4p-cat5e-solid-lszh_1.1200x1000.jpg,7170c.1200x1000.jpg,7170c.3.1200x1000.jpg', 'Четырехпарный кабель категории 5e на основе витой пары предназначен для использования в системах передачи данных со скоростью до 2.5 Гбит/c. Кабель выполнен в неэкранированном исполнении U/UTP и предназначен для прокладки внутри зданий. Диаметр проводников составляет 0,50 мм (24 AWG). Внешняя оболочка выполнена из не распространяющего горение LSZH-компаунда, малодымного и не выделяющего ядовитых соединений в процессе горения, исполнение нг(А)-HF. На внешней оболочке кабеля нанесены метровые метки длины кабеля.\r\nКабель обладает отличными характеристиками при разумной цене, что делает его оптимальным вариантом для построения сетей в проектах, в том числе где требуется гарантийная системная поддержка. Кабель поставляется в картонной коробке «easy-pull box».', '1'),
(23, 'Кабель силовой медный ВВГ-Пнг(А)-LS 3x2,5 мм, длина 50 метров, ГОСТ 31996-2012, ТУ 16.К71-310-2001 REXANT 01-8272-50', 3, 1, '01-8272-50', 8871.82, 9458.34, 'шт.', 'sds-rexant-01-8272-50.1200x1000.jpg', 'sds-rexant-01-8272-50.1200x1000.jpg', 'Кабель ВВГ-Пнг(А)-LS силовой с пластмассовой изоляцией, в оболочке из поливинилхлоридного пластиката пониженной горючести. Кабели соответствуют требованиям ГОСТ 31996-2012.\r\n\r\nПрименение:\r\nПредназначен для передачи и распределения электрической энергии в стационарных установках на номинальное переменное напряжение в основном 0,66 и 1 кВ номинальной частотой 50 Гц. Кабель применяется для групповой прокладки в кабельных сооружениях наружных (открытых) электроустановок (кабельных эстакадах, галереях). Кабели изготавливаются для эксплуатации в кабельных сооружениях и помещениях, в том числе для использования в системе атомных станций классов 3 и 4 по классификации ОПБ-88 (ПНАЭ Г-01-011-97). Кабель не распространяет горение как при одиночной, так и при групповой прокладке.', '1');

-- --------------------------------------------------------

--
-- Структура таблицы `products_related`
--

CREATE TABLE `products_related` (
  `product_id` int UNSIGNED NOT NULL,
  `related_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `products_related`
--

INSERT INTO `products_related` (`product_id`, `related_id`) VALUES
(21, 20),
(20, 21),
(20, 22),
(21, 22);

-- --------------------------------------------------------

--
-- Структура таблицы `products_stocks`
--

CREATE TABLE `products_stocks` (
  `product_id` int UNSIGNED NOT NULL,
  `count` smallint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `products_stocks`
--

INSERT INTO `products_stocks` (`product_id`, `count`) VALUES
(23, 76),
(20, 135),
(21, 156);

-- --------------------------------------------------------

--
-- Структура таблицы `products_variations`
--

CREATE TABLE `products_variations` (
  `product_id` int UNSIGNED NOT NULL,
  `variation_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `products_variations`
--

INSERT INTO `products_variations` (`product_id`, `variation_id`) VALUES
(21, 20),
(22, 20),
(20, 21),
(22, 21),
(20, 22),
(21, 22);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int UNSIGNED NOT NULL,
  `first_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `second_name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `age` int UNSIGNED NOT NULL,
  `gender` enum('male','female') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `phone` char(18) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `first_name`, `second_name`, `age`, `gender`, `email`, `phone`, `password`) VALUES
(16, 'Тест', 'Тест', 44, 'male', 'jopaj@mail.su', '79999999999', '$2y$10$9uQhtPQG.1TcN8CGeDn1/ez3603bAEqtLX4mj58zEhSvgiHtgD2VW');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- Индексы таблицы `admins_roles`
--
ALTER TABLE `admins_roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`),
  ADD KEY `name` (`name`);

--
-- Индексы таблицы `admins_roles_permissions`
--
ALTER TABLE `admins_roles_permissions`
  ADD UNIQUE KEY `role_id` (`role_id`,`permission_id`),
  ADD KEY `to_permissions_id2` (`permission_id`);

--
-- Индексы таблицы `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD KEY `brand_name` (`name`);

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `categories_filters`
--
ALTER TABLE `categories_filters`
  ADD UNIQUE KEY `category_id` (`category_id`,`filter_id`),
  ADD KEY `filter_id` (`filter_id`);

--
-- Индексы таблицы `categories_types`
--
ALTER TABLE `categories_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name_2` (`name`,`category_id`),
  ADD KEY `name` (`name`),
  ADD KEY `type_category_id` (`category_id`),
  ADD KEY `code` (`code`);

--
-- Индексы таблицы `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`user_id`,`product_id`) USING BTREE,
  ADD KEY `FavGoodsCall` (`product_id`);

--
-- Индексы таблицы `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `User_id` (`user_id`,`product_id`),
  ADD KEY `FitToGoodsCall` (`product_id`) USING BTREE;

--
-- Индексы таблицы `filters`
--
ALTER TABLE `filters`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `filters_values`
--
ALTER TABLE `filters_values`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `value` (`value`,`code`,`filter_id`),
  ADD KEY `filterCall` (`filter_id`);

--
-- Индексы таблицы `filters_values_products`
--
ALTER TABLE `filters_values_products`
  ADD PRIMARY KEY (`filter_value_id`,`product_id`),
  ADD KEY `FilterToGoodsCall` (`product_id`),
  ADD KEY `filter_value_id` (`filter_value_id`);

--
-- Индексы таблицы `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `news` ADD FULLTEXT KEY `Text` (`text`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Number` (`number`),
  ADD KEY `User_id` (`user_id`);

--
-- Индексы таблицы `orders_products`
--
ALTER TABLE `orders_products`
  ADD PRIMARY KEY (`product_id`,`order_id`),
  ADD KEY `OrderGToOrders` (`order_id`);

--
-- Индексы таблицы `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code_2` (`code`),
  ADD KEY `name` (`name`);

--
-- Индексы таблицы `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`,`article`),
  ADD UNIQUE KEY `Article` (`article`),
  ADD KEY `Title` (`title`),
  ADD KEY `product_brand_id` (`brand_id`),
  ADD KEY `product_category_type_id` (`category_type_id`),
  ADD KEY `unit` (`unit`);

--
-- Индексы таблицы `products_related`
--
ALTER TABLE `products_related`
  ADD PRIMARY KEY (`product_id`,`related_id`) USING BTREE,
  ADD KEY `Related_id` (`related_id`) USING BTREE,
  ADD KEY `Goods_id` (`product_id`) USING BTREE;

--
-- Индексы таблицы `products_stocks`
--
ALTER TABLE `products_stocks`
  ADD UNIQUE KEY `product_id` (`product_id`),
  ADD KEY `count` (`count`);

--
-- Индексы таблицы `products_variations`
--
ALTER TABLE `products_variations`
  ADD PRIMARY KEY (`product_id`,`variation_id`) USING BTREE,
  ADD KEY `Variation_id` (`variation_id`) USING BTREE,
  ADD KEY `Base_id` (`product_id`) USING BTREE;

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Email` (`email`),
  ADD UNIQUE KEY `Phone` (`phone`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `admins_roles`
--
ALTER TABLE `admins_roles`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `categories_types`
--
ALTER TABLE `categories_types`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT для таблицы `feedbacks`
--
ALTER TABLE `feedbacks`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `filters`
--
ALTER TABLE `filters`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT для таблицы `filters_values`
--
ALTER TABLE `filters_values`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=93;

--
-- AUTO_INCREMENT для таблицы `news`
--
ALTER TABLE `news`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `products`
--
ALTER TABLE `products`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `to_admins_roles_id3` FOREIGN KEY (`role_id`) REFERENCES `admins_roles` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `admins_roles_permissions`
--
ALTER TABLE `admins_roles_permissions`
  ADD CONSTRAINT `to_admins_roles_id2` FOREIGN KEY (`role_id`) REFERENCES `admins_roles` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `to_permissions_id2` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `categories_filters`
--
ALTER TABLE `categories_filters`
  ADD CONSTRAINT `category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `filter_id` FOREIGN KEY (`filter_id`) REFERENCES `filters` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `categories_types`
--
ALTER TABLE `categories_types`
  ADD CONSTRAINT `type_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `favorites`
--
ALTER TABLE `favorites`
  ADD CONSTRAINT `FavGoodsCall` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `FavUserCall` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `feedbacks`
--
ALTER TABLE `feedbacks`
  ADD CONSTRAINT `FitToGoodsCall` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `FitToUserCall` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `filters_values`
--
ALTER TABLE `filters_values`
  ADD CONSTRAINT `filterCall` FOREIGN KEY (`filter_id`) REFERENCES `filters` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `filters_values_products`
--
ALTER TABLE `filters_values_products`
  ADD CONSTRAINT `to_filters_values_id` FOREIGN KEY (`filter_value_id`) REFERENCES `filters_values` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `to_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `OrderToUser` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `orders_products`
--
ALTER TABLE `orders_products`
  ADD CONSTRAINT `OrderGToGoods` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `OrderGToOrders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `product_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_category_type_id` FOREIGN KEY (`category_type_id`) REFERENCES `categories_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `products_related`
--
ALTER TABLE `products_related`
  ADD CONSTRAINT `products_related_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_related_ibfk_2` FOREIGN KEY (`related_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `products_stocks`
--
ALTER TABLE `products_stocks`
  ADD CONSTRAINT `to_count_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Ограничения внешнего ключа таблицы `products_variations`
--
ALTER TABLE `products_variations`
  ADD CONSTRAINT `products_variations_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `products_variations_ibfk_2` FOREIGN KEY (`variation_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
