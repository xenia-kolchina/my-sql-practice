-- БАЗОВАЯ ВЫБОРКА ДАННЫХ (SELECT, FROM, LIMIT, OFFSET)
-- 1. SELECT & FROM: Извлечение данных из конкретных столбцов таблицы
SELECT name, email 
FROM users;
-- 2. LIMIT: Ограничение количества строк (например, для топ-5 или тестов)
SELECT * 
FROM products 
LIMIT 5;
-- 3. OFFSET: Пропуск первых N строк (используется для пагинации)
-- Выведет 10 записей, начиная с 21-й
SELECT * 
FROM orders 
LIMIT 10 OFFSET 20;
-- 4. ПРАКТИЧЕСКИЙ ПРИМЕР: Пагинация с сортировкой
-- Порядок важен: SELECT -> FROM -> ORDER BY -> LIMIT -> OFFSET
SELECT id, title 
FROM posts 
ORDER BY created_at DESC 
LIMIT 20 OFFSET 0; -- Первая страница (по 20 элементов)

-- БАЗОВЫЕ ТИПЫ ДАННЫХ
CREATE TABLE transactions (
    id INT,                      -- Целое число
    amount DECIMAL(10,2),        -- Точное число (деньги)
    user_name VARCHAR(50),       -- Строка переменной длины
    is_active BOOLEAN,           -- Логический тип
    created_at TIMESTAMP         -- Дата и время
);
-- Примеры явных преобразований данных
SELECT 
    -- CAST: универсальный стандарт SQL
    CAST('100' AS INT) AS string_to_int,
    CAST(amount AS VARCHAR) AS decimal_to_string,
    -- :: оператор (синтаксис PostgreSQL)
    '2023-10-27'::DATE AS string_to_date,
    id::FLOAT AS int_to_float,
    -- CONVERT: специфично для SQL Server/MySQL (форматирование даты)
    -- CONVERT(VARCHAR, created_at, 104) AS formatted_date, 
    -- Неявное преобразование (автоматическое при расчетах)
    id + 0.5 AS implicit_float
FROM transactions;

-- ФИЛЬТРАЦИЯ И СОРТИРОВКА (WHERE, ORDER BY, AND/OR, COUNT)
-- 1. WHERE: Фильтрация строк по условию
-- Использует операторы: =, !=, <, >, <=, >=
SELECT * FROM employees 
WHERE salary > 50000;
-- 2. AND & OR: Логические связки для нескольких условий
-- AND — должны выполняться оба; OR — хотя бы одно
SELECT * FROM orders 
WHERE status = 'shipped' AND total_price > 100;
-- 3. ORDER BY: Сортировка результата
-- ASC (по возрастанию, по умолчанию), DESC (по убыванию)
SELECT name, hire_date 
FROM employees 
ORDER BY hire_date DESC;
-- 4. COUNT: Агрегатная функция для подсчета строк
-- Считает количество записей, попадающих под фильтр
SELECT COUNT(*) AS active_users_count 
FROM users 
WHERE last_login > '2023-01-01';
-- ПРАКТИЧЕСКИЙ ПРИМЕР: Все вместе
SELECT category, COUNT(*) 
FROM products 
WHERE stock > 0 AND price < 1000  -- Фильтруем
GROUP BY category                 -- Группируем (если нужен счет по категориям)
ORDER BY category ASC;            -- Сортируем

-- РАБОТА СО СТРОКАМИ, ПОИСК И УСЛОВИЯ (CASE, LIKE, IN, REPLACE, СРЕЗЫ)
-- 1. КОММЕНТАРИИ
-- Однострочный комментарий (два тире)
/* Многострочный 
   комментарий */
-- 2. СРЕЗЫ: LEFT & RIGHT
-- Извлекают N символов с начала или конца строки
SELECT 
    LEFT(phone, 4) AS country_code,   -- Первые 4 символа
    RIGHT(email, 3) AS domain_zone    -- Последние 3 символа
FROM users;
-- 3. SPLIT_PART: Разделение строки по разделителю
-- Синтаксис: (строка, разделитель, номер части)
-- Пример: разделение 'Ivan-Ivanov' на имя и фамилию
SELECT 
    SPLIT_PART(full_name, '-', 1) AS first_name,
    SPLIT_PART(full_name, '-', 2) AS last_name
FROM contacts;
-- 4. REPLACE: Замена подстроки
-- Синтаксис: (поле, что меняем, на что меняем)
SELECT REPLACE(url, 'http://', 'https://') AS secure_url 
FROM sites;
-- 5. LIKE & IN: Фильтрация и поиск
-- % — любое кол-во символов, _ — один символ
SELECT * FROM products 
WHERE title LIKE '%Apple%'             -- Поиск по шаблону
  AND category IN ('Tech', 'Mobile');  -- Проверка вхождения в список
-- ПОИСК ПО ШАБЛОНУ (LIKE)
-- 5.1. Поиск подстроки (в любом месте)
SELECT * FROM users WHERE email LIKE '%@gmail.com%';
-- 5.2. Поиск по началу или концу
SELECT * FROM items WHERE code LIKE 'ABC%'; -- Начинается на ABC
SELECT * FROM files WHERE name LIKE '%.pdf'; -- Заканчивается на .pdf
-- 5.3. Точное кол-во символов (_)
SELECT * FROM tags WHERE slug LIKE '___'; -- Ровно 3 любых символа
-- 5.4. Исключение (NOT LIKE)
SELECT * FROM tasks WHERE title NOT LIKE 'Test%';
-- 5.5. Регистр (ILIKE — только для PostgreSQL)
SELECT * FROM products WHERE name ILIKE '%apple%'; -- Найдет Apple, APPLE, apple
-- 6. CASE ... WHEN: Логика категорий (IF-THEN-ELSE в SQL)
-- Позволяет создавать новые колонки на основе условий
SELECT 
    title,
    price,
    CASE 
        WHEN price > 1000 THEN 'Premium'
        WHEN price BETWEEN 500 AND 1000 THEN 'Mid-range'
        ELSE 'Budget'
    END AS price_category
FROM products;

-- АГРЕГАЦИЯ И СВОДНЫЕ ТАБЛИЦЫ (GROUP BY, HAVING, АГРЕГАТЫ)
-- 1. АГРЕГАТНЫЕ ФУНКЦИИ
SELECT 
    COUNT(*) AS total_rows,          -- Всего строк
    COUNT(DISTINCT category) AS cats, -- Уникальных категорий
    SUM(amount) AS total_sum,        -- Сумма всех значений
    AVG(price) AS average_price,     -- Среднее арифметическое
    MIN(score) AS lowest,            -- Минимальное
    MAX(score) AS highest            -- Максимальное
FROM sales;
-- 2. GROUP BY: Группировка для сводной таблицы
-- Разделяет данные на группы по указанному столбцу
SELECT 
    category, 
    SUM(amount) AS category_sum
FROM orders
GROUP BY category;
-- 3. HAVING: Фильтрация ПОСЛЕ агрегации
-- В отличие от WHERE, работает с результатами функций (SUM, COUNT и т.д.)
SELECT 
    client_id, 
    COUNT(*) AS orders_count
FROM orders
GROUP BY client_id
HAVING COUNT(*) > 5; -- Выбрать только тех, у кого больше 5 заказов
-- ПРАКТИЧЕСКИЙ ПРИМЕР: Полноценный отчет
SELECT 
    store_id,
    COUNT(id) AS sales_count,
    AVG(total) AS avg_check
FROM sales
WHERE status = 'completed' -- Сначала фильтруем строки
GROUP BY store_id          -- Затем группируем
HAVING AVG(total) > 500    -- Затем фильтруем группы
ORDER BY avg_check DESC;   -- В конце сортируем

-- ==========================================================
-- ТЕОРИЯ ПО INNER JOIN, LEFT JOIN, ON, USING. UNION
-- ==========================================================
-- INNER JOIN: Пересечение
-- Выводит только те строки, для которых нашлось совпадение в обеих таблицах.
-- Виктор (id 3) и Часы (user_id 5) не попадут в результат.
-- ==========================================================
SELECT Users.name, Orders.product
FROM Users
INNER JOIN Orders ON Users.id = Orders.user_id;
-- ==========================================================
-- LEFT JOIN: Все слева + совпадения справа
-- Выводит ВСЕХ пользователей. Если у пользователя нет заказа (Виктор), 
-- в колонке product будет NULL.
-- ==========================================================
SELECT Users.name, Orders.product
FROM Users
LEFT JOIN Orders ON Users.id = Orders.user_id;
-- ==========================================================
-- УСЛОВИЯ СВЯЗИ: ON vs USING
-- ==========================================================
-- ON: Универсален. Можно связывать колонки с разными именами.
SELECT * FROM Users JOIN Orders ON Users.id = Orders.user_id;
-- USING: Лаконичный синтаксис. Работает, ТОЛЬКО если имена колонок 
-- в обеих таблицах одинаковые (например, если бы в Orders был столбец 'id').
-- SELECT * FROM Users JOIN Orders USING(id);
-- ==========================================================
-- UNION: Вертикальное объединение
-- Не склеивает строки по горизонтали, а добавляет результаты одного 
-- запроса под результаты другого. 
-- ТРЕБОВАНИЕ: Одинаковое количество и тип колонок.
-- ==========================================================
-- UNION: Убирает дубликаты.
-- UNION ALL: Оставляет всё (работает быстрее).
SELECT name AS label FROM Users
UNION
SELECT product AS label FROM Orders;

