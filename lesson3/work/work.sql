create database if not exists gb_3;
use gb_3;
drop table if exists test;
create table if not exists test
(
    id        int primary key auto_increment,
    firstname varchar(45)
);

# ----------------------------------

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

select *
from staff;

select id, salary, concat(firstname, ' ', lastname) AS fullname # "1" + " " + "1" = "1 1"
from staff
order by salary desc;

select id, firstname, lastname, salary
from staff
order by lastname desc, firstname desc, salary desc;

select distinct lastname, count(lastname) as count
from staff
group by lastname
order by lastname
limit 10;

select post,
       round(avg(age), 1)        as age_avg,
       round(avg(salary), 2)     as salary_avg,
       count(salary)             as workers_count,
       min(salary)               as salary_min,
       max(salary)               as salary_max,
       max(salary) - min(salary) as salary_diff
from staff
where post not in ('Начальник', 'Уборщик')
group by post
having avg(salary) > 25000;
# Условие для сформированного списка (после group by)

########################################################################################################################
# # Создадим архив документов по месяцам (сколько документов было создано в каждом месяце)
# SET sql_mode = (SELECT REPLACE(@@sql_mode, 'ONLY_FULL_GROUP_BY', ''));
# SELECT COUNT(id)             AS count_media,
#        MONTHNAME(created_at) AS month_name, # 05 - May
#        MONTH(created_at)     AS month_number
# FROM media
# GROUP BY month_name
# ORDER BY MONTH(created_at);
#
# # Сколько документов у каждого пользователя
# SELECT user_id,
#        COUNT(id)                                                AS count_media,
#        (SELECT email FROM users WHERE users.id = media.user_id) AS user_email
# FROM media
# GROUP BY user_id
# ORDER BY COUNT(id) DESC
# LIMIT 5;