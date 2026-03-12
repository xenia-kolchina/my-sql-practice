-- Начиная с 12.03.2026 решаю в день 5 задач с SQL Academy.

-- ДЕНЬ 1 (12.03.2026). Темы 1-6 по SQL от Changellenge, решение первых 5 задач с SQL Academy.
-- Задача 1. Имена всех людей
-- Вывести имена всех людей, которые есть в базе данных авиакомпаний
select Passenger.name 
from Passenger
-- Задача 2. Названия всех авиакомпаний
-- Вывести названия всеx авиакомпаний
select Passenger.name 
from Passenger
-- Задача 3. Рейсы из Москвы
-- Вывести все рейсы, совершенные из Москвы
SELECT *
FROM Trip
WHERE Trip.town_from = 'Moscow'
-- Задача 4. Имена, заканчивающиеся на "man"
-- Вывести имена людей, которые заканчиваются на "man"
SELECT Passenger.name
FROM Passenger
WHERE Passenger.name LIKE '%man'
-- Задача 5. Количество рейсов на TU-134
-- Вывести количество рейсов, совершенных на TU-134
-- Используйте конструкцию "as count" для агрегатной функции подсчета количества рейсов. Это необходимо для корректной проверки.
SELECT COUNT(*) as count
FROM Trip
WHERE Trip.plane = 'TU-134'
