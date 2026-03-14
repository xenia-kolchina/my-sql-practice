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

-- ДЕНЬ 3 (14.03.2026). Тема 7 по SQL от Changellenge, решение задач 11-15 с SQL Academy.
-- Задача 11. Пассажиры с самым длинным ФИО
-- Выведите пассажиров с самым длинным ФИО. Пробелы, дефисы и точки считаются частью имени.
select Passenger.name 
from Passenger
ORDER BY LENGTH(Passenger.name) DESC
limit 2 -- Как я должна была догадаться, что надо вывести только двоих? В условии ничего об этом нет
-- Задача 12. Количество пассажиров на рейсах
-- Выведите идентификаторы всех рейсов и количество пассажиров на них. Обратите внимание, что на каких-то рейсах пассажиров может не быть. 
-- В этом случае выведите число "0".
-- Используйте конструкцию "as count" для агрегатной функции подсчета количества пассажиров. Это необходимо для корректной проверки.
select count(Pass_in_trip.Passenger) as count,
Trip.id
from Trip
left join Pass_in_trip
on Trip.id = Pass_in_trip.trip
group by Trip.id
-- Задача 13. Полные тёзки
-- Вывести имена людей, у которых есть полный тёзка среди пассажиров
select Passenger.name
from Passenger
group by Passenger.name
having count(Passenger.name) > 1
-- Задача 14. Города, которые посетил Bruce Willis
-- В какие города летал Bruce Willis
SELECT DISTINCT Trip.town_to
FROM Trip
JOIN Pass_in_trip ON Trip.id = Pass_in_trip.trip
JOIN Passenger ON Pass_in_trip.passenger = Passenger.id
WHERE Passenger.name = 'Bruce Willis'
-- Задача 15. Прибытие Steve Martin в Лондон
-- Выведите идентификатор пассажира Стив Мартин (Steve Martin) и дату и время его прилёта в Лондон (London)
SELECT Passenger.id, Trip.time_in
FROM Trip
JOIN Pass_in_trip ON Trip.id = Pass_in_trip.trip
JOIN Passenger ON Pass_in_trip.passenger = Passenger.id
WHERE Passenger.name = 'Steve Martin' AND 
Trip.town_to = 'London'
