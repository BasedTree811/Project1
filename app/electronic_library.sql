-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Июн 22 2026 г., 11:39
-- Версия сервера: 10.4.32-MariaDB
-- Версия PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `electronic_library`
--

-- --------------------------------------------------------

--
-- Структура таблицы `books`
--

CREATE TABLE `books` (
  `id_book` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `publish_year` int(11) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `books`
--

INSERT INTO `books` (`id_book`, `title`, `author`, `genre`, `publish_year`, `description`, `file_path`) VALUES
(7, 'Гарри Поттер', 'Дж. К. Роулинг', 'Фэнтези', NULL, 'История юного меня', 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
(8, 'Война и мир (том 1)', 'Лев Толстой', 'Роман', NULL, 'Классическое произведение', 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
(9, 'Преступление и наказание', 'Федор Достоевский', 'Роман', NULL, 'Психологический роман', 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
(10, '1984', 'Джордж Оруэлл', 'Антиутопия', NULL, 'Тоталитарное общество', 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
(11, 'Мастер и Маргарита', 'Михаил Булгаков', 'Мистика', NULL, 'История Воланда', 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
(16, '1984', 'Джордж Оруэлл', 'Антиутопия', NULL, '...', 'http://...'),
(20, 'Тест', 'Я', 'Тест', NULL, 'тест', 'https://example.com/book.pdf'),
(21, 'Лекция', 'Адрей', 'учебник', NULL, 'да', 'http://127.0.0.1/library_api/uploads/book_6a38d64362fd18.68928115.pdf');

-- --------------------------------------------------------

--
-- Структура таблицы `book_issue`
--

CREATE TABLE `book_issue` (
  `id_issue` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_book` int(11) NOT NULL,
  `issue_date` date NOT NULL,
  `return_date_plan` date DEFAULT NULL,
  `return_date_fact` date DEFAULT NULL,
  `status` enum('issued','returned') DEFAULT 'issued'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `favorites`
--

CREATE TABLE `favorites` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_book` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `favorites`
--

INSERT INTO `favorites` (`id`, `id_user`, `id_book`) VALUES
(1, 7, 7),
(2, 9, 14),
(3, 9, 14),
(4, 0, 14),
(5, 0, 10),
(6, 1, 10),
(7, 9, 7),
(8, 9, 8),
(9, 9, 8),
(10, 9, 8),
(11, 9, 8),
(12, 9, 8),
(13, 9, 8),
(14, 9, 18),
(15, 11, 7),
(16, 0, 7),
(17, 11, 8),
(18, 11, 11),
(19, 13, 8),
(20, 13, 20),
(21, 12, 21);

-- --------------------------------------------------------

--
-- Структура таблицы `favorites_books`
--

CREATE TABLE `favorites_books` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_book` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_book` int(11) NOT NULL,
  `read_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `history`
--

INSERT INTO `history` (`id`, `id_user`, `id_book`, `read_date`) VALUES
(3, 9, 14, '2026-06-10 17:44:25'),
(4, 9, 14, '2026-06-10 17:58:50'),
(5, 9, 14, '2026-06-10 18:00:28'),
(6, 9, 14, '2026-06-10 18:16:19'),
(7, 9, 7, '2026-06-10 18:16:39'),
(8, 9, 9, '2026-06-10 18:26:55'),
(9, 9, 7, '2026-06-10 18:26:59'),
(10, 9, 14, '2026-06-10 18:27:04'),
(11, 7, 14, '2026-06-10 18:27:25'),
(12, 9, 15, '2026-06-10 18:28:18'),
(13, 9, 10, '2026-06-18 15:47:20'),
(14, 11, 9, '2026-06-18 19:51:55'),
(15, 11, 7, '2026-06-18 19:52:05'),
(16, 11, 8, '2026-06-22 05:50:36'),
(17, 11, 11, '2026-06-22 05:50:57'),
(18, 13, 7, '2026-06-22 05:51:47'),
(19, 13, 20, '2026-06-22 05:56:03'),
(20, 13, 7, '2026-06-22 06:20:40'),
(21, 13, 8, '2026-06-22 06:20:57'),
(22, 13, 21, '2026-06-22 06:29:43'),
(23, 12, 21, '2026-06-22 06:30:17');

-- --------------------------------------------------------

--
-- Структура таблицы `reader_rating`
--

CREATE TABLE `reader_rating` (
  `id_rating` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `total_points` int(11) DEFAULT 0,
  `rating_place` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `reading_history`
--

CREATE TABLE `reading_history` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_book` int(11) DEFAULT NULL,
  `read_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `reviews`
--

CREATE TABLE `reviews` (
  `id_review` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_book` int(11) NOT NULL,
  `review_text` text DEFAULT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` >= 1 and `rating` <= 5),
  `review_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `patronymic` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `login` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('reader','admin') DEFAULT 'reader',
  `rating` int(11) DEFAULT 0,
  `token` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id_user`, `surname`, `name`, `patronymic`, `phone`, `email`, `login`, `password`, `role`, `rating`, `token`) VALUES
(1, '', '', NULL, NULL, '', '', '', 'reader', 0, NULL),
(4, 'Гаврико', 'Дима', NULL, NULL, 'ashdyeh@gmail.com', 'giga', '12345678', 'reader', 0, NULL),
(6, 'Admin', 'Administrator', NULL, NULL, 'admin@library.com', 'admin', 'admin', 'admin', 0, '1a55b4535b70f26bddca849709fbf36e9d164d25fb401c635997ff20cfe522e3'),
(11, 'Иван', 'Иванов', NULL, NULL, 'invan@gmail.com', 'user1', '123456', '', 4, 'b562b078f72734d3bc76b0159ca94e808bfc2fd5b54d6404cc7de2721177c882'),
(12, '1', '1', NULL, NULL, 'r@f', '1', '1', '', 1, '2a243e709e0dc4dc5ef9f061ed016afd33cb0e8d23b5b4b622058ec27259b745'),
(13, 'Дима', 'Дима', NULL, NULL, 'dima@', 'Dima', '123456', '', 5, 'ec40e5bee69ec3a9edc7b8b546dc0681c8a1a899bd37989b7cb541f2c220c7d5');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id_book`);

--
-- Индексы таблицы `book_issue`
--
ALTER TABLE `book_issue`
  ADD PRIMARY KEY (`id_issue`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_book` (`id_book`);

--
-- Индексы таблицы `favorites`
--
ALTER TABLE `favorites`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `favorites_books`
--
ALTER TABLE `favorites_books`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_book` (`id_book`);

--
-- Индексы таблицы `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `reader_rating`
--
ALTER TABLE `reader_rating`
  ADD PRIMARY KEY (`id_rating`),
  ADD KEY `id_user` (`id_user`);

--
-- Индексы таблицы `reading_history`
--
ALTER TABLE `reading_history`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id_review`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_book` (`id_book`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `login` (`login`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `books`
--
ALTER TABLE `books`
  MODIFY `id_book` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `book_issue`
--
ALTER TABLE `book_issue`
  MODIFY `id_issue` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT для таблицы `favorites_books`
--
ALTER TABLE `favorites_books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT для таблицы `reader_rating`
--
ALTER TABLE `reader_rating`
  MODIFY `id_rating` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `reading_history`
--
ALTER TABLE `reading_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id_review` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `book_issue`
--
ALTER TABLE `book_issue`
  ADD CONSTRAINT `book_issue_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `book_issue_ibfk_2` FOREIGN KEY (`id_book`) REFERENCES `books` (`id_book`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `favorites_books`
--
ALTER TABLE `favorites_books`
  ADD CONSTRAINT `favorites_books_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE,
  ADD CONSTRAINT `favorites_books_ibfk_2` FOREIGN KEY (`id_book`) REFERENCES `books` (`id_book`) ON DELETE CASCADE;

--
-- Ограничения внешнего ключа таблицы `reader_rating`
--
ALTER TABLE `reader_rating`
  ADD CONSTRAINT `reader_rating_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`id_book`) REFERENCES `books` (`id_book`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
