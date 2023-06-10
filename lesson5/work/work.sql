USE gb_5;
# --------------------
drop table if exists staff;
create table if not exists staff
(
    id        int(16) primary key auto_increment,
    firstname varchar(64) not null,
    lastname  varchar(64) not null,
    post      varchar(64) not null,
    seniority int(16),
    salary    decimal(8, 2), # 100 000 . 00
    age       int(2)
) auto_increment = 0;

insert into staff (firstname, lastname, post, seniority, salary, age)
values ('Петр', 'Петров', 'Начальник', 8, 70000, 30),
       ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
       ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
       ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
       ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
       ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
       ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
       ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
       ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
       ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
       ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
       ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
       ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);

drop table if exists shop;
create table if not exists shop
(
    id          int(16) primary key auto_increment,
    shopping_day date,
    department varchar(64),
    count       int(16)
) auto_increment = 0;
insert into shop(shopping_day, department, count)
values ('2022-12-21', 'Бытовая техника', 3),
       ('2022-12-21', 'Свежая выпечка', 4),
       ('2022-12-21', 'Напитки', 4),
       ('2022-12-22', 'Бытовая техника', 1),
       ('2022-12-22', 'Свежая выпечка', 3),
       ('2022-12-22', 'Напитки', 3),
       ('2022-12-22', 'Замороженные продукты', 1),
       ('2022-12-23', 'Бытовая техника', 2),
       ('2022-12-23', 'Свежая выпечка', 4),
       ('2022-12-23', 'Замороженные продукты', 4);
# --------------------

SELECT * FROM staff;

-- Ранжирование
-- Вывести список всех сотрудников и указать место в рейтинге по ЗП
SELECT
    salary,
    post,
    concat(firstname, " ", lastname) AS fullname,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS `dense_rank`
FROM staff;

-- Ранжирование
-- Вывести список всех сотрудников и указать место в рейтинге по ЗП
-- Но по каждой специальности
SELECT
    salary,
    post,
    concat(firstname, " ", lastname) AS fullname,
    DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `dense_rank`
FROM staff;

-- Найдите самых высокооплачиваемых сотрудников в каждой специальности
SELECT
    salary,
    post,
    fullname,
    `dense_rank`
FROM (SELECT
          salary,
          post,
          concat(firstname, " ", lastname) AS fullname,
          DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `dense_rank`
      FROM staff) rank_salary
WHERE `dense_rank` = 1;
-- ТОП2 самых высокооплачиваемых сотрудников в каждой специальности

SELECT
    salary,
    post,
    fullname,
    `dense_rank`
FROM (SELECT
          salary,
          post,
          concat(firstname, " ", lastname) AS fullname,
          DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `dense_rank`
      FROM staff) rank_salary
WHERE `dense_rank` IN (1,2); -- dense_rank = 1 OR dense_rank = 2

-- Агрегация
-- Вывести по должностям:
-- суммарную ЗП
-- среднюю ЗП
-- процентное соотношение отдельно взятой ЗП к суммарной ЗП по должности
SELECT
    salary,
    post,
    concat(firstname, " ", lastname) AS fullname,
    SUM(salary) OVER w AS sum_salary, -- (PARTITION BY post)
    AVG(salary) OVER w AS avg_salary,
    ROUND(salary * 100 / SUM(salary) OVER w,  2) AS percent_sum_salary
FROM staff
WINDOW w AS (PARTITION BY post);

SELECT
    salary,
    post,
    concat(firstname, " ", lastname) AS fullname,
    round(AVG(salary) OVER w) AS salary_avg
FROM staff
WINDOW w AS (
        ORDER BY salary DESC
        ROWS BETWEEN 1 PRECEDING AND
            1 FOLLOWING -- Между 1 предыдущей и 1 следующей (-1 0 1)
        );
-- представления
SELECT
    COUNT(*) AS count_staff,
    post,
    AVG(salary) AS `avg`
FROM staff
GROUP BY post
ORDER BY count_staff;

CREATE OR REPLACE VIEW count_post
AS
SELECT
    COUNT(*) AS count_staff,
    post,
    AVG(salary) AS `avg`
FROM staff
GROUP BY post
ORDER BY count_staff;

SELECT * -- count_staff, post, avg
FROM count_post;