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

-- ДЕНЬ 2 (13.03.2026). Тема 7 по SQL от Changellenge, решение задач 6-10 с SQL Academy.
-- Задача 6. Компании, летавшие на Boeing
-- Какие компании совершали перелеты на Boeing
SELECT DISTINCT name
FROM Trip
LEFT JOIN 
Company
ON Trip.company = Company.id
AND Trip.plane = 'Boeing'
WHERE name is NOT NULL 

-- Задача 7. Самолеты, летящие в Москву
-- Вывести все названия самолётов, на которых можно улететь в Москву (Moscow)
select DISTINCT Trip.plane
from Trip
where Trip.town_to = 'Moscow'

-- Задача 8. Полёты из Парижа
-- В какие города можно улететь из Парижа (Paris) и сколько времени это займёт?
-- Используйте конструкцию "as flight_time" для вывода необходимого времени. Это необходимо для корректной проверки.
-- Формат для вывода времени: HH:MM:SS
select DISTINCT Trip.town_to,
TIMEDIFF(Trip.time_in, Trip.time_out) as flight_time
from Trip
where Trip.town_from = 'Paris'

-- Задача 9. Компании с рейсами из Владивостока
-- Какие компании организуют перелеты из Владивостока (Vladivostok)? 
select name
from Trip
left JOIN 
Company
on Trip.company = Company.id
where town_from = 'Vladivostok'

-- Задача 10. Вылеты в определенное время
-- Вывести вылеты, совершенные с 10 ч. по 14 ч. 1 января 1900 г.
select *
from Trip
where Trip.time_out BETWEEN '1900-01-01T10:00:00.000Z' and '1900-01-01T14:00:00.000Z'

