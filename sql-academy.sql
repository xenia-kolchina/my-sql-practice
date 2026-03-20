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

-- ДЕНЬ 4 (15.03.2026). Решение задач 16-20 с SQL Academy.
-- Задача 16. Сортировка пассажиров по количеству полетов
-- Вывести отсортированный по количеству перелетов (по убыванию) и имени (по возрастанию) список пассажиров, совершивших хотя бы 1 полет.
select count(Pass_in_trip.passenger) as count,
Passenger.name
from Pass_in_trip
join Passenger on Pass_in_trip.passenger = Passenger.id
group by Passenger.name
order by count desc, Passenger.name asc
-- Задача 17. Траты членов семьи в 2005 году
-- Определить, сколько потратил в 2005 году каждый из членов семьи. В результирующей выборке не выводите тех членов семьи, которые ничего не потратили.
SELECT FamilyMembers.member_name,
FamilyMembers.`status`,
SUM(Payments.amount * Payments.unit_price) as costs
FROM Payments
JOIN FamilyMembers ON Payments.family_member = FamilyMembers.member_id
where date(Payments.`date`) BETWEEN '2005-01-01 00:00:00' and '2006-01-01 00:00:00'
GROUP BY FamilyMembers.member_name,
FamilyMembers.`status`
-- Задача 18. Самый старший человек
-- Выведите имя самого старшего человека. Если таких несколько, то выведите их всех.
SELECT FamilyMembers.member_name
FROM FamilyMembers
ORDER BY FamilyMembers.birthday ASC 
LIMIT 1
-- Задача 19. Кто покупал картошку
-- Определить, кто из членов семьи покупал картошку (potato)
SELECT DISTINCT FamilyMembers.`status`
FROM FamilyMembers
JOIN Payments ON Payments.family_member = FamilyMembers.member_id
JOIN Goods ON Goods.good_id = Payments.good
WHERE Goods.good_name = 'potato'
-- Задача 20. Траты на развлечения
-- Сколько и кто из семьи потратил на развлечения (entertainment). Вывести статус в семье, имя, сумму
SELECT FamilyMembers.`status`,
FamilyMembers.member_name,
SUM(Payments.amount * Payments.unit_price) as costs
FROM FamilyMembers
JOIN Payments ON Payments.family_member = FamilyMembers.member_id
JOIN Goods ON Goods.good_id = Payments.good
JOIN GoodTypes ON GoodTypes.good_type_id = Goods.type
WHERE GoodTypes.good_type_name = 'entertainment'
GROUP BY FamilyMembers.`status`,
FamilyMembers.member_name

-- ДЕНЬ 5 (16.03.2026). Тема 8 от Changellenge. Решение задач 21-25 с SQL Academy.
-- Задача 21. Товары, купленные более одного раза
-- Определить товары, которые покупали более 1 раза
SELECT Goods.good_name
FROM Goods
JOIN Payments ON Payments.good = Goods.good_id
GROUP by Goods.good_name
HAVING COUNT(Payments.good) > 1
-- Задача 22. Имена всех матерей
-- Найти имена всех матерей (mother)
SELECT FamilyMembers.member_name
FROM FamilyMembers
WHERE FamilyMembers.`status` = 'mother'
-- Задача 23. Самый дорогой деликатес
-- Найдите самый дорогой деликатес (delicacies) и выведите его цену
SELECT Goods.good_name,
MAX(Payments.unit_price) as unit_price
FROM GoodTypes
JOIN Goods on GoodTypes.good_type_id = Goods.type
JOIN Payments on Goods.good_id = Payments.good
where GoodTypes.good_type_name = 'delicacies'
GROUP by Goods.good_name
limit 1
-- Задача 24. Кто и сколько потратил в июне 2005 года
-- Определить, кто и сколько потратил в июне 2005
SELECT FamilyMembers.member_name, sum(Payments.amount * Payments.unit_price) as costs
FROM Payments
JOIN FamilyMembers on FamilyMembers.member_id = Payments.family_member
WHERE Payments.`date` BETWEEN '2005-06-01' and '2005-07-01'
GROUP by FamilyMembers.member_name
-- Задача 25. Товары, не купленные в 2005 году
-- Определить, какие товары не покупались в 2005 году. 
-- Повторить вложенные запросы/подзапросы
select Goods.good_name
FROM Goods
WHERE Goods.good_name not in
(SELECT Goods.good_name
FROM Payments
left JOIN Goods ON Payments.good = Goods.good_id
WHERE Payments.`date` BETWEEN '2005-01-01' and '2006-01-01')

-- ДЕНЬ 6 (17.03.2026). Решение задач 26-30 с SQL Academy.
-- Задача 26. Группы товаров, не купленные в 2005 году
-- Определить группы товаров, которые не приобретались в 2005 году
select GoodTypes.good_type_name
from GoodTypes 
where GoodTypes.good_type_name not in 
(select GoodTypes.good_type_name
from GoodTypes
join Goods on GoodTypes.good_type_id = Goods.type
join Payments on Payments.good = Goods.good_id
where Payments.`date` between '2005-01-01' and '2006-01-01')
-- Задача 27. Траты по группам товаров в 2005 году
-- Узнайте, сколько было потрачено на каждую из групп товаров в 2005 году. 
-- Выведите название группы и потраченную на неё сумму. Если потраченная сумма равна нулю, т.е. товары из этой группы не покупались в 2005 году, то не выводите её.
select GoodTypes.good_type_name, 
sum(Payments.amount * Payments.unit_price) as costs
from Payments
INNER JOIN Goods ON Goods.good_id = Payments.good
INNER JOIN GoodTypes ON GoodTypes.good_type_id = Goods.type
WHERE Payments.`date` between '2005-01-01' and '2006-01-01'
GROUP by GoodTypes.good_type_name
-- Задача 28. Рейсы из Ростова в Москву
-- Сколько рейсов совершили авиакомпании из Ростова (Rostov) в Москву (Moscow) ?
select count(*) as count
from Trip
where Trip.town_from = 'Rostov' and Trip.town_to = 'Moscow'
-- Задача 29. Имена пассажиров, летящих в Москву
-- Выведите имена пассажиров, улетевших в Москву (Moscow) на самолете TU-134. В ответе не должно быть дубликатов.
select DISTINCT Passenger.name
FROM Passenger
JOIN Pass_in_trip on Pass_in_trip.passenger = Passenger.id
JOIN Trip on Trip.id = Pass_in_trip.trip
where Trip.town_to = 'Moscow' and Trip.plane = 'TU-134'
-- Задача 30. Нагруженность рейсов
-- Вывести количество занятых мест по каждому рейсу из таблицы Pass_in_trip, отсортировав результат по убыванию количества занятых мест.
select Pass_in_trip.trip,
count(Pass_in_trip.place) as `count`
from Pass_in_trip
group by Pass_in_trip.trip
order by `count` desc
  
-- ДЕНЬ 7 (18.03.2026). Решение задач 31-35 с SQL Academy.
-- Задача 31. Члены семьи Quincey
-- Вывести всех членов семьи с фамилией Quincey.
select *
from FamilyMembers
where right(FamilyMembers.member_name,7) = 'Quincey'
-- Задача 32. Средний возраст людей
-- Вывести средний возраст людей (в годах), хранящихся в базе данных. Результат округлите до целого в меньшую сторону.
SELECT FLOOR(AVG(TIMESTAMPDIFF(YEAR, FamilyMembers.birthday, CURDATE()))) as age
from FamilyMembers
-- Задача 33. Средняя цена икры
-- Найдите среднюю цену икры на основе данных, хранящихся в таблице Payments. В базе данных хранятся данные о покупках красной (red caviar) 
-- и черной икры (black caviar). В ответе должна быть одна строка со средней ценой всей купленной когда-либо икры.
SELECT avg(Payments.unit_price) as cost
FROM Payments
JOIN Goods on Goods.good_id = Payments.good
WHERE Goods.good_name = 'red caviar' or Goods.good_name = 'black caviar'
-- Задача 34. Количество 10-х классов
-- Сколько всего 10-ых классов
select count(*) as count
from Class
where left(Class.name,2) = '10'
-- Задача 35. Кабинеты, использованные 2 сентября 2019
-- Сколько различных кабинетов школы использовались 2 сентября 2019 года для проведения занятий?
SELECT count(DISTINCT Schedule.classroom) as count
FROM Schedule
WHERE Schedule.`date` = '2019-09-02'

-- ДЕНЬ 8 (19.03.2026). Решение задач 36-40 с SQL Academy.
-- Задача 36. Обучающиеся, живущие на улице Пушкина
-- Выведите информацию об обучающихся, живущих на улице Пушкина (ul. Pushkina)?
select *
from Student
where left(Student.address,12) = 'ul. Pushkina'
-- Задача 37. Возраст самого молодого обучающегося
-- Сколько лет самому молодому обучающемуся ?
SELECT TIMESTAMPDIFF(YEAR,Student.birthday,CURDATE()) as `year`
FROM Student
ORDER BY TIMESTAMPDIFF(YEAR,Student.birthday,CURDATE()) ASC 
limit 1
-- Задача 38. Количество учениц с именем Анна
-- Сколько учениц с именем Анна (Anna) учится в школе?
SELECT count(*) as count
FROM Student
WHERE lower(Student.first_name) = 'anna'
-- Задача 39. Количество обучающихся в 10 B классе 
-- Сколько обучающихся в 10 B классе ?
SELECT COUNT(*) AS count
FROM Student_in_class
JOIN Class ON Student_in_class.class = Class.id
WHERE Class.name = '10 B';
-- Задача 40. Предметы Ромашкина П.П.
-- Выведите название предметов, которые преподает Ромашкин П.П. (Romashkin P.P.). Обратите внимание, что в базе данных есть несколько учителей с такой фамилией.
SELECT Subject.name as subjects

-- ДЕНЬ 9 (20.03.2026). Решение задач 41-45 с SQL Academy.
-- Задача 41. Начало четвёртого занятия
-- Выясните, во сколько по расписанию начинается четвёртое занятие.
select Timepair.start_pair 
from Timepair
where Timepair.id = 4
-- Задача 42. Время, проведённое в школе
-- Сколько времени обучающийся будет находиться в школе, учась со 2-го по 4-ый уч. предмет?
select TIMEDIFF((select Timepair.end_pair
from Timepair
where Timepair.id = 4),
(select Timepair.start_pair
from Timepair
where Timepair.id = 2)) as time
-- Задача 43. Преподаватели физкультуры
-- Выведите фамилии преподавателей, которые ведут физическую культуру (Physical Culture). Отсортируйте преподавателей по фамилии в алфавитном порядке.
SELECT Teacher.last_name
from Teacher
JOIN `Schedule` ON `Schedule`.teacher = Teacher.id
JOIN Subject on `Schedule`.subject = Subject.id
where Subject.name = 'Physical Culture'
ORDER by Teacher.last_name asc
-- Задача 44. Максимальный возраст в 10 классах
-- Найдите максимальный возраст (количество лет) среди обучающихся 10 классов на сегодняшний день. Для получения текущих даты и времени используйте функцию NOW().
select TIMESTAMPDIFF(YEAR,Student.birthday,CURDATE()) as max_year
from Student
join Student_in_class on Student.id = Student_in_class.student
join Class on Student_in_class.class = Class.id
where Class.name like '%10%'
order by max_year DESC 
limit 1
-- Задача 45. Самые используемые кабинеты
-- Какие кабинеты чаще всего использовались для проведения занятий? Выведите те, которые использовались максимальное количество раз.
SELECT `Schedule`.classroom
FROM `Schedule`
GROUP BY `Schedule`.classroom
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM Schedule
    GROUP BY classroom
    ORDER BY COUNT(*) DESC
    LIMIT 1)
