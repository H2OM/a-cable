-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июн 15 2026 г., 02:36
-- Версия сервера: 8.0.30
-- Версия PHP: 8.3.31

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
(3, 'Rexant', 'rexant'),
(4, 'Неизвестно', 'unknown');

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
(1, 'Кабельная продукция', 'cable-products', 'cable.jpg'),
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
(1, 3),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 14),
(1, 120),
(1, 121),
(1, 122),
(1, 123),
(1, 124),
(1, 125),
(1, 126),
(1, 127),
(1, 128),
(1, 129),
(1, 130),
(1, 131),
(1, 132),
(1, 134),
(1, 135),
(1, 258),
(1, 276),
(1, 277),
(1, 279),
(1, 282),
(1, 284),
(1, 285),
(1, 287),
(1, 292),
(1, 295),
(1, 760);

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
(8, 'Акустический кабель', 'speaker-cable', 1),
(9, 'Лампочки', 'bulbs', 2),
(10, 'Светодиодные ленты', 'led-strips', 2),
(11, 'Светильники', 'lamps', 2),
(12, 'Прожекторы', 'spotlights', 2),
(13, 'Уличные фонари', 'street-lights', 2),
(14, 'Розетки', 'sockets', 3),
(15, 'Выключатели', 'switches', 3),
(16, 'Установочные коробки', 'mounting-boxes', 3),
(17, 'Рамки', 'frames', 3),
(18, 'Отвертки', 'Screwdrivers', 4),
(19, 'Сварочные аппараты', 'welding-machines', 4),
(20, 'Инструменты для зачистки и обрезки кабеля', 'cable-tools', 4),
(21, 'Пресс-клещи для обжима наконечников', 'crimping-pliers', 4),
(22, 'Измерительный инструмент', 'measuring-tool', 4),
(23, 'Шарнирно-губцевый инструмент', 'pliers', 4),
(24, 'Коммутаторы', 'commutators', 4),
(25, 'Маршрутизаторы', 'routers', 4),
(26, 'Трансиверы', 'transceivers', 4),
(27, 'Устройства для печати', 'printing-devices', 4),
(28, 'PoE оборудование', 'PoE-equipment', 4);

-- --------------------------------------------------------

--
-- Структура таблицы `delivery_types`
--

CREATE TABLE `delivery_types` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `address` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `price` int UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `delivery_types`
--

INSERT INTO `delivery_types` (`id`, `name`, `address`, `price`) VALUES
(1, 'Самовывоз', 'г. Москва проезд ...', 0),
(2, 'Доставка в пределах МКАД', '', 1000),
(3, 'СДЭК', '', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `favorites`
--

CREATE TABLE `favorites` (
  `user_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `code` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` enum('switch','multi','range','') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `position` tinyint UNSIGNED NOT NULL DEFAULT '127'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `filters`
--

INSERT INTO `filters` (`id`, `filter`, `code`, `type`, `position`) VALUES
(1, 'Сортировка', 'sort', 'switch', 1),
(2, 'Скидка', 'sale', 'switch', 4),
(3, 'Тип', 'type', 'multi', 2),
(4, 'Бренд', 'brand', 'multi', 3),
(5, 'Цена', 'price', 'range', 5),
(7, 'Цвет', 'color', 'multi', 127),
(8, 'Длинна', 'length', 'multi', 127),
(9, 'Кол-во пар', 'pairs_count', 'multi', 127),
(10, 'Исполнение', 'perfomance', 'multi', 127),
(11, 'Кол-во проводников', 'cores_count', 'multi', 127),
(12, 'Сечение кабеля', 'cable_section', 'multi', 127),
(14, 'Номинальное напряжение', 'rated_voltage', 'multi', 127),
(120, 'Кол-во пар', 'pairscount', 'multi', 127),
(121, 'Оболочка', 'shell', 'multi', 127),
(122, 'Прокладка', 'laying', 'multi', 127),
(123, 'Категория', 'categories', 'multi', 127),
(124, 'Экранирование', 'shield', 'multi', 127),
(125, 'Проводник (конструкция)', 'vein', 'multi', 127),
(126, 'Тип экрана', 'shieldtype', 'multi', 127),
(127, 'Наличие троса', 'nalichietrosa', 'multi', 127),
(128, 'Калибр', 'kalibr', 'multi', 127),
(129, 'Материал проводника', 'veinmaterial', 'multi', 127),
(130, 'Исполнение', 'performance', 'multi', 127),
(131, 'Упаковка', 'upakovka', 'multi', 127),
(132, 'Скорость передачи данных', 'datarate', 'multi', 127),
(133, 'Включен в реестр МИНПРОМТОРГ', 'vklyuchenvreestrminp', 'multi', 127),
(134, 'Диаметр проводника', 'diametrspprovodnika', 'multi', 127),
(135, 'Длина шнура', 'cordlength', 'multi', 127),
(258, 'Серия', 'series', 'multi', 127),
(276, 'Кол-во проводников', 'veincount', 'multi', 127),
(277, 'Материал', 'material', 'multi', 127),
(278, 'Номинальное напряжение', 'nominalnoenapryazhen', 'multi', 127),
(279, 'Тип кабеля', 'cabletype', 'multi', 127),
(280, 'Номин. сечение проводника', 'nomindspsecheniesppr', 'multi', 127),
(281, 'Температура эксплуатации', 'temperaturaspeksplua', 'multi', 127),
(282, 'Назначение кабеля', 'purposecable', 'multi', 127),
(283, 'Допустимая температура при эксплуатации (без движения)', 'dopustimayasptempera', 'multi', 127),
(284, 'Исполнение кабеля', 'ispolneniespkabelya', 'multi', 127),
(285, 'Изоляция жилы', 'izolyatsiyaspzhily', 'multi', 127),
(286, 'Сечение кабеля (Max)', 'secheniespkabelyaspl', 'multi', 127),
(287, 'Несущий элемент', 'nesuschijspelement', 'multi', 127),
(288, 'Цвет внешн. оболочки', 'tsvetspvneshndspobol', 'multi', 127),
(289, 'Материал изоляции жилы', 'materialspizolyatsii', 'multi', 127),
(290, 'Материал внешн. оболочки', 'materialspvneshndspo', 'multi', 127),
(291, 'Бронирование/армирование', 'bronirovaniefarmirov', 'multi', 127),
(292, 'Класс проводника', 'klassspprovodnika', 'multi', 127),
(293, 'Заземляющая жила', 'zazemlyayuschayaspzh', 'multi', 127),
(294, 'Номин. напряжение U (линейное)', 'nomindspnapryazhenie', 'multi', 127),
(295, 'Цвет жилы', 'tsvetspzhily', 'multi', 127),
(760, 'Включен в реестр МИНПРОМТОРГ', 'vklyuchenvreestrminpromtorga', 'multi', 127);

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
(349, '0.48 мм', '0d48spmm', 134),
(186, '0.50 мм', '0d50spmm', 134),
(1068, '0.51 мм', '0d51spmm', 134),
(1069, '0.52 мм', '0d52spmm', 134),
(346, '0.57 мм', '0d57spmm', 134),
(314, '1', '1', 120),
(378, '1', '1', 276),
(398, '10 м', '10spm', 8),
(351, '100 метров', '100spmetrov', 135),
(313, '2', '2', 120),
(380, '2', '2', 276),
(77, '2.5 мм^2', '2d5mm', 12),
(400, '20 м', '20spm', 8),
(330, '23 AWG', '23spawg', 128),
(179, '24 AWG', '24spawg', 128),
(399, '25 м', '25spm', 8),
(331, '26 AWG', '26spawg', 128),
(81, '3', '3', 11),
(381, '3', '3', 276),
(396, '3 м', '3spm', 8),
(73, '305 м', '305m', 8),
(187, '305 метров', '305spmetrov', 135),
(74, '4', '4', 9),
(76, '4', '4', 11),
(167, '4', '4', 120),
(379, '4', '4', 276),
(397, '5 м', '5spm', 8),
(78, '50 м', '50m', 8),
(401, '50 м', '50spm', 8),
(350, '500 метров', '500spmetrov', 135),
(80, '660 В', '660v', 14),
(347, '7x0.16 мм', '7x0d16spmm', 134),
(348, '7x0.20 мм', '7x0d20spmm', 134),
(177, 'F/UTP', 'ffutp', 126),
(353, 'Light', 'light', 258),
(318, 'LSLTx', 'lsltx', 121),
(408, 'LSt-Полиэтилен', 'lstmpolietilen', 285),
(316, 'LSZH', 'lszh', 121),
(169, 'LSZH + UV', 'lszhsppspuv', 121),
(395, 'NUM-J', 'nummj', 279),
(394, 'NUM-О', 'nummo', 279),
(315, 'PE / Полиэтилен', 'pespfsppolietilen', 121),
(168, 'PVC / ПВХ', 'pvcspfsppvh', 121),
(326, 'S/FTP', 'sfftp', 126),
(327, 'SF/UTP', 'sffutp', 126),
(328, 'U/FTP', 'ufftp', 126),
(176, 'U/UTP', 'ufutp', 126),
(404, 'АвтоЭлектрика', 'avtoelektrika', 282),
(386, 'Алюминий', 'alyuminij', 129),
(385, 'Алюминий', 'alyuminij', 277),
(57, 'Бежевый', 'beige', 7),
(337, 'Белый', 'belyj', 7),
(55, 'Белый', 'white', 7),
(58, 'Бордовый', 'vinous', 7),
(184, 'В бухте', 'vspbuhte', 131),
(183, 'В коробке', 'vspkorobke', 131),
(392, 'ВВГ-Пнг(А)', 'vvgmpnglbarb', 279),
(82, 'ВВГ-Пнг(А)-LS', 'vvg-png-a-ls', 10),
(393, 'ВВГ-Пнг(А)-LS', 'vvgmpnglbarbmls', 279),
(319, 'Внешняя', 'vneshnyaya', 122),
(170, 'Внутренняя', 'vnutrennyaya', 122),
(59, 'Голубой', 'blue', 7),
(174, 'Да', 'da', 124),
(329, 'Да', 'da', 127),
(1499, 'Да', 'da', 760),
(4, 'Да', 'yes', 2),
(345, 'До 0,01 Гбит/с', 'dosp0c01spgbitfs', 132),
(344, 'До 0,1 Гбит/с', 'dosp0c1spgbitfs', 132),
(1070, 'До 1 Гбит/с', 'dosp1spgbitfs', 132),
(343, 'До 10 Гбит/с', 'dosp10spgbitfs', 132),
(185, 'До 2.5 Гбит/с', 'dosp2d5spgbitfs', 132),
(342, 'До 40 Гбит/с', 'dosp40spgbitfs', 132),
(341, 'До 5 Гбит/с', 'dosp5spgbitfs', 132),
(336, 'Жёлтый', 'zheltyj', 7),
(63, 'Зеленый', 'green', 7),
(335, 'Зелёный', 'zelenyj', 7),
(172, 'Кат. 5e', 'katdsp5e', 123),
(320, 'Кат. 6', 'katdsp6', 123),
(323, 'Кат. 6a', 'katdsp6a', 123),
(322, 'Кат. 7', 'katdsp7', 123),
(321, 'Кат. 7а', 'katdsp7a', 123),
(324, 'Кат. 8', 'katdsp8', 123),
(388, 'КГтп-ХЛ', 'kgtpmhl', 279),
(411, 'Класс 1 (однопроволочная жила)', 'klasssp1splbodnoprovolochnay', 292),
(338, 'Коричневый', 'korichnevyj', 7),
(334, 'Красный', 'krasnyj', 7),
(405, 'Круглый', 'kruglyj', 284),
(384, 'Медь', 'med', 277),
(180, 'Медь (Cu)', 'medsplbcurb', 129),
(382, 'Многожильный', 'mnogozhilnyj', 125),
(325, 'Многожильный (patсh)', 'mnogozhilnyjsplbpatshrb', 125),
(60, 'Мультиколор', 'multicolor', 7),
(75, 'нг(А)-HF', 'ng-a-hf', 10),
(339, 'нг(А)-HF', 'nglbarbmhf', 130),
(182, 'нг(А)-LS', 'nglbarbmls', 130),
(340, 'нг(А)-LSLTx', 'nglbarbmlsltx', 130),
(412, 'Несколько', 'neskolko', 295),
(173, 'Нет', 'net', 124),
(178, 'Нет', 'net', 127),
(1533, 'Нет', 'net', 760),
(5, 'Нет', 'no', 2),
(410, 'Нет (без)', 'netsplbbezrb', 287),
(383, 'Одножильный', 'odnozhilnyj', 125),
(175, 'Одножильный (solid)', 'odnozhilnyjsplbsolidrb', 125),
(387, 'Омедненный алюминий', 'omednennyjspalyuminij', 129),
(61, 'Оранжевый', 'orange', 7),
(332, 'Оранжевый', 'oranzhevyj', 7),
(317, 'Отсутствует', 'otsutstvuet', 121),
(390, 'ПВС', 'pvs', 279),
(409, 'ПВХ-Пластикат', 'pvhmplastikat', 285),
(391, 'ПГВА', 'pgva', 279),
(406, 'Плоский', 'ploskij', 284),
(1, 'По возрастанию цены', 'low-to-high', 1),
(352, 'По метрам', 'pospmetram', 135),
(3, 'По популярности', 'by-popular', 1),
(2, 'По убыванию цены', 'high-to-low', 1),
(62, 'Розовый', 'pink', 7),
(72, 'Серый', 'gray', 7),
(160, 'Серый', 'seryj', 7),
(333, 'Синий', 'sinij', 7),
(389, 'СИП-4', 'sipm4', 279),
(407, 'ТЭП-Пластикат', 'tepmplastikat', 285),
(171, 'Универсальная', 'universalnaya', 122),
(402, 'Установочный', 'ustanovochnyj', 282),
(56, 'Черный', 'black', 7),
(181, 'Чёрный', 'chernyj', 7),
(403, 'Электропроводка', 'elektroprovodka', 282);

-- --------------------------------------------------------

--
-- Структура таблицы `filters_values_products`
--

CREATE TABLE `filters_values_products` (
  `filter_value_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `news`
--

CREATE TABLE `news` (
  `id` int UNSIGNED NOT NULL,
  `title` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `position` tinyint UNSIGNED NOT NULL DEFAULT '127'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `news`
--

INSERT INTO `news` (`id`, `title`, `text`, `image`, `position`) VALUES
(1, 'Масштабное снижение цен!', 'Скидки до 50% на самые востребованные категории кабельной продукции и оборудования. Успейте зафиксировать выгоду для ваших проектов.', 'sales-banner.png', 2),
(2, 'Встречайте новый бренд — Cabeus!', ' Мировой стандарт качества в нашем каталоге. Полный ассортимент структурированных кабельных систем (СКС) уже доступен для заказа.', 'cabeus-banner.png', 1),
(3, 'Персональные предложения и скидки', 'Подпишитесь на нашу информационную рассылку. Получайте только актуальные прайс-листы, закрытые распродажи и аналитику рынка первыми.', 'personal-banner.jpg\r\n', 127),
(4, 'Время обновить освещение?', 'От бытовых лампочек до промышленного и уличного светодиодного оборудования. Надежные решения с гарантией высокой энергоэффективности.', 'light.png', 127),
(5, 'Выгода для постоянных клиентов', 'Зарегистрируйтесь на сайте и получите дополнительную скидку 10% на первый заказ. Управляйте покупками через удобный личный кабинет.', 'email-banner.jpg', 127);

-- --------------------------------------------------------

--
-- Структура таблицы `orders`
--

CREATE TABLE `orders` (
  `id` int UNSIGNED NOT NULL,
  `number` char(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `status` enum('0','1','2','3','4') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `user_id` int UNSIGNED NOT NULL,
  `delivery_type_id` int UNSIGNED NOT NULL,
  `payment_type_id` int UNSIGNED NOT NULL,
  `delivery_address` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `price` mediumint UNSIGNED NOT NULL,
  `delivery_price` smallint UNSIGNED NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `change_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery_date` date NOT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `orders`
--

INSERT INTO `orders` (`id`, `number`, `status`, `user_id`, `delivery_type_id`, `payment_type_id`, `delivery_address`, `price`, `delivery_price`, `date`, `change_date`, `delivery_date`, `comment`) VALUES
(47, '92c4973cc13e4', '1', 16, 2, 1, 'Калатушкина 2', 79946, 1000, '2026-06-02 15:32:33', '2026-06-02 15:32:33', '0000-00-00', ''),
(48, 'e80bff5fc58e3', '1', 16, 2, 1, 'Калатушкина 2', 79946, 1000, '2026-06-02 15:41:03', '2026-06-02 15:41:03', '0000-00-00', ''),
(49, '905f803973939', '4', 16, 1, 1, 'г. Москва проезд ...', 78946, 0, '2026-06-02 15:44:38', '2026-06-02 15:44:38', '0000-00-00', ''),
(50, '81069e194c5fa', '0', 16, 1, 1, 'г. Москва проезд ...', 78946, 0, '2026-06-02 15:47:43', '2026-06-02 15:47:43', '0000-00-00', ''),
(51, 'fa5c343977790', '0', 16, 1, 1, 'г. Москва проезд ...', 78946, 0, '2026-06-02 15:51:47', '2026-06-02 15:51:47', '0000-00-00', ''),
(52, '5a9bb632c3418', '0', 16, 1, 1, 'г. Москва проезд ...', 78946, 0, '2026-06-02 15:53:21', '2026-06-02 15:53:21', '0000-00-00', ''),
(53, '90eb8b84214f0', '0', 16, 1, 1, 'г. Москва проезд ...', 61823, 0, '2026-06-02 16:02:49', '2026-06-02 16:02:49', '0000-00-00', ''),
(54, 'd849193cfe8f2', '0', 16, 1, 1, 'г. Москва проезд ...', 44899, 0, '2026-06-02 16:03:46', '2026-06-02 16:03:46', '0000-00-00', ''),
(55, '764d5dff7fffd', '2', 30, 2, 1, 'г. Москва, Пресненская наб., 10 блок С', 61041, 1000, '2026-06-09 11:42:16', '2026-06-09 11:42:16', '2026-06-10', ''),
(56, 'ad373ead5cf0a', '4', 30, 3, 1, 'г. Москва, Большой Саввинский переулок, 2к1', 15342, 0, '2026-06-09 12:22:55', '2026-06-09 12:22:55', '2026-06-11', ''),
(66, 'abaf4a76ca8b3', '0', 16, 1, 1, 'г. Москва проезд ...', 121426, 0, '2026-06-11 21:59:18', '2026-06-11 21:59:18', '0000-00-00', ''),
(67, '4e4e13127f833', '0', 16, 2, 1, 'г. Москва проезд ...', 9372, 1000, '2026-06-11 22:00:29', '2026-06-11 22:00:29', '0000-00-00', '');

-- --------------------------------------------------------

--
-- Структура таблицы `orders_products`
--

CREATE TABLE `orders_products` (
  `order_id` int UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `count` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `payment_types`
--

CREATE TABLE `payment_types` (
  `id` int UNSIGNED NOT NULL,
  `name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `payment_types`
--

INSERT INTO `payment_types` (`id`, `name`) VALUES
(1, 'Оплата при получении');

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
  `category_type_id` int UNSIGNED DEFAULT NULL,
  `brand_id` int UNSIGNED NOT NULL,
  `article` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `price` float NOT NULL DEFAULT '0',
  `price_old` float NOT NULL DEFAULT '0',
  `unit` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Untitled.jpg',
  `slider_images` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci COMMENT 'example.jpg,example2.jpg,example3.jpg...',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `hit` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `products_related`
--

CREATE TABLE `products_related` (
  `product_id` int UNSIGNED NOT NULL,
  `related_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `products_stocks`
--

CREATE TABLE `products_stocks` (
  `product_id` int UNSIGNED NOT NULL,
  `count` smallint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `products_variations`
--

CREATE TABLE `products_variations` (
  `product_id` int UNSIGNED NOT NULL,
  `variation_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(16, 'Тест', 'Тест', 44, 'male', 'dima.zabolotnov.02@mail.ru', '79999999999', '$2y$10$Zt5JHqRP3RqIuIiyK/XgD.munQ1/vssnmQQ5pieS2hl/4jojAqV2i'),
(30, 'Дмитрий', 'Тестов', 24, 'male', 'dima.zabolotnov.03@mail.ru', '79911919191', '$2y$10$xFZQLfr8Bp2EjyBKywryXOdsWyH/E7ZHkIPdJY7ZXqFSehh9hAZD2');

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
  ADD UNIQUE KEY `code_2` (`code`),
  ADD KEY `name` (`name`),
  ADD KEY `type_category_id` (`category_id`),
  ADD KEY `code` (`code`);

--
-- Индексы таблицы `delivery_types`
--
ALTER TABLE `delivery_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`),
  ADD KEY `address` (`address`);

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `position` (`position`);
ALTER TABLE `news` ADD FULLTEXT KEY `Text` (`text`);

--
-- Индексы таблицы `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Number` (`number`),
  ADD KEY `User_id` (`user_id`),
  ADD KEY `to_delivery_id` (`delivery_type_id`),
  ADD KEY `to_payment_id` (`payment_type_id`),
  ADD KEY `delivery_address` (`delivery_address`);

--
-- Индексы таблицы `orders_products`
--
ALTER TABLE `orders_products`
  ADD PRIMARY KEY (`product_id`,`order_id`),
  ADD KEY `OrderGToOrders` (`order_id`);

--
-- Индексы таблицы `payment_types`
--
ALTER TABLE `payment_types`
  ADD PRIMARY KEY (`id`),
  ADD KEY `name` (`name`);

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
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `categories_types`
--
ALTER TABLE `categories_types`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT для таблицы `delivery_types`
--
ALTER TABLE `delivery_types`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `feedbacks`
--
ALTER TABLE `feedbacks`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `filters`
--
ALTER TABLE `filters`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1151;

--
-- AUTO_INCREMENT для таблицы `filters_values`
--
ALTER TABLE `filters_values`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1900;

--
-- AUTO_INCREMENT для таблицы `news`
--
ALTER TABLE `news`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT для таблицы `payment_types`
--
ALTER TABLE `payment_types`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `products`
--
ALTER TABLE `products`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1025;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

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
  ADD CONSTRAINT `OrderToUser` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  ADD CONSTRAINT `to_delivery_id` FOREIGN KEY (`delivery_type_id`) REFERENCES `delivery_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `to_payment_id` FOREIGN KEY (`payment_type_id`) REFERENCES `payment_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
  ADD CONSTRAINT `to_count_products_id` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

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
