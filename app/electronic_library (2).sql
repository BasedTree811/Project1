-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Июн 10 2026 г., 22:18
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
(7, 'Гарри Поттер', 'Дж. К. Роулинг', 'Фэнтези', NULL, 'История юного волшебника', 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
(8, 'Война и мир', 'Лев Толстой', 'Роман', NULL, 'Классическое произведение', 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
(9, 'Преступление и наказание', 'Федор Достоевский', 'Роман', NULL, 'Психологический роман', 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
(10, '1984', 'Джордж Оруэлл', 'Антиутопия', NULL, 'Тоталитарное общество', 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
(11, 'Мастер и Маргарита', 'Михаил Булгаков', 'Мистика', NULL, 'История Воланда', 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
(12, '', '', '', NULL, '', ''),
(13, '', '', '', NULL, '', ''),
(14, 'Тест', 'Автор', 'Учебник', NULL, 'Проверка', 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'),
(15, 'ТЕСТ', 'Я', 'РОК', NULL, 'в', 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf');

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
-- Структура таблицы `borrowings`
--

CREATE TABLE `borrowings` (
  `id` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_book` int(11) DEFAULT NULL,
  `borrow_date` date DEFAULT NULL,
  `return_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `borrowings`
--

INSERT INTO `borrowings` (`id`, `id_user`, `id_book`, `borrow_date`, `return_date`) VALUES
(1, 2, 7, NULL, '2026-06-30'),
(2, 0, 0, '2026-06-09', '2026-06-23');

-- --------------------------------------------------------

--
-- Структура таблицы `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id_message` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_librarian` int(11) NOT NULL,
  `message_text` text NOT NULL,
  `send_date` datetime DEFAULT current_timestamp()
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
(5, 0, 10);

-- --------------------------------------------------------

--
-- Структура таблицы `favorites_books`
--

CREATE TABLE `favorites_books` (
  `id` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_book` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Дамп данных таблицы `favorites_books`
--

INSERT INTO `favorites_books` (`id`, `id_user`, `id_book`) VALUES
(9, 7, 7),
(10, 8, 10);

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
(12, 9, 15, '2026-06-10 18:28:18');

-- --------------------------------------------------------

--
-- Структура таблицы `librarians`
--

CREATE TABLE `librarians` (
  `id_librarian` int(11) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `patronymic` varchar(50) DEFAULT NULL,
  `login` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `position` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(6, 'Admin', 'Administrator', NULL, NULL, 'admin@library.com', 'admin', 'admin', 'admin', 0, '4b476850dc8af4435b089f14c3f9a46d2ed65d040873b7c4719dff3e4624cf12'),
(7, 'я', 'я', NULL, NULL, 'я', 'я', 'я', '', 1, 'd1c9c7c9add762f62570c9609b03b63d5e8c8b863cfa31f62813c97009b00e2b'),
(8, 'ы', 'ы', NULL, NULL, 'ы', 'ы', 'ы', '', 0, '5b376fa53d4402c63c4fafee0d069ad0b9066c7e0c49628e58af358b1f2061d7'),
(9, '1', '1', NULL, NULL, '1', '1', '1', '', 4, '238a7f4f55b82608354ad410114c53d7c279d2bfaf0a4d661cfe15578ab8f68a'),
(10, '2', '2', NULL, NULL, '2@', '2', '$2y$10$hQI6UGrTu618Q.LGb0W0Hupl8Gs69abjpXgK9WaaLakDHKD064Gcm', 'reader', 0, NULL);

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
-- Индексы таблицы `borrowings`
--
ALTER TABLE `borrowings`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id_message`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_librarian` (`id_librarian`);

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
-- Индексы таблицы `librarians`
--
ALTER TABLE `librarians`
  ADD PRIMARY KEY (`id_librarian`),
  ADD UNIQUE KEY `login` (`login`);

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
  MODIFY `id_book` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT для таблицы `book_issue`
--
ALTER TABLE `book_issue`
  MODIFY `id_issue` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `borrowings`
--
ALTER TABLE `borrowings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id_message` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `favorites`
--
ALTER TABLE `favorites`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `favorites_books`
--
ALTER TABLE `favorites_books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `librarians`
--
ALTER TABLE `librarians`
  MODIFY `id_librarian` int(11) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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
-- Ограничения внешнего ключа таблицы `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD CONSTRAINT `chat_messages_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `chat_messages_ibfk_2` FOREIGN KEY (`id_librarian`) REFERENCES `librarians` (`id_librarian`) ON DELETE CASCADE ON UPDATE CASCADE;

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
