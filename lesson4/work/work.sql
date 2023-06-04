create database if not exists gb_4;
use gb_4;

# --- work1.sql ----------------------------------------
select *
from lesson l
         left join teacher t on t.id = l.teacher_id;

SELECT teacher.id, teacher.surname, teacher.salary, lesson.course
from teacher
         JOIN lesson ON lesson.teacher_id = teacher.id;

SELECT t.surname,
       l.course
FROM teacher AS t
         JOIN lesson AS l
              ON t.id = l.teacher_id;

-- Получим фамилии учителей и курсы, которые они ведут
SELECT t.surname,
       l.course, -- t = teacher, l = lesson
       l.teacher_id,
       t.id
FROM teacher t -- t = teacher,
         JOIN lesson l -- INNER JOIN = JOIN, l = lesson
              ON t.id = l.teacher_id;

SELECT t.surname,
       l.course
FROM teacher t
         LEFT JOIN lesson l
                   ON t.id = teacher_id;

SELECT t.surname,
       l.course
FROM teacher t
         LEFT JOIN lesson l
                   ON t.id = teacher_id
WHERE l.course IS NULL;

SELECT t.surname,
       l.course, -- t = teacher, l = lesson
       l.teacher_id,
       t.id
FROM teacher t -- t = teacher,
         JOIN lesson l -- INNER JOIN = JOIN, l = lesson
              ON t.id = l.teacher_id
WHERE l.course = "Знакомство с веб-технологиями";

-- Получим инфо о учителях, которые ведут "Веб-технологии"
SELECT t.surname,
       l.course, -- t = teacher, l = lesson
       l.teacher_id,
       t.id
FROM teacher t -- t = teacher,
         JOIN lesson l -- INNER JOIN = JOIN, l = lesson
              ON t.id = l.teacher_id
WHERE l.course = "Знакомство с веб-технологиями";

-- Подзапрос
SELECT t.*,
       web_lesson.* -- course, teacher_id
FROM teacher t
         JOIN (SELECT course, teacher_id
               FROM lesson
               WHERE course = "Знакомство с веб-технологиями") web_lesson
              ON t.id = web_lesson.teacher_id;

# --- work2.sql ----------------------------------------
-- Выборка данных по пользователю: ФИО, город проживания, фотки
SELECT u.firstname,
       u.lastname,            -- u = users
       p.hometown AS city,    -- p = profiles
       m.filename AS medifile -- m = media
FROM users u
         JOIN `profiles` p ON p.user_id = u.id -- Получил  p.hometown
         JOIN media m ON p.photo_id = m.id;

-- Все файлы
SELECT u.firstname,
       u.lastname,            -- u = users
       p.hometown AS city,    -- p = profiles
       m.filename AS medifile -- m = media
FROM users u
         JOIN `profiles` p ON p.user_id = u.id -- Получил  p.hometown
         JOIN media m ON m.user_id = u.id;

select u.id,
       concat(u.lastname, ' ', u.firstname) as name,
       m.filename,
       count(m.id)                          as likes
from users u
         left join media m on m.user_id = u.id
         left join likes l on m.id = l.media_id
group by m.id
order by likes desc
limit 10;

-- Список медиафайлов пользователя, указывая название типа файла
SELECT m.filename   AS medifile,
       mt.name_type AS mediatype
FROM media m
         LEFT JOIN media_types mt
                   ON m.media_type_id = mt.id;

select u.id,
       concat(u.lastname, ' ', u.firstname) as name,
       mt.name_type as type,
       count(mt.id) as count
from users u
         left join media m on u.id = m.user_id
         left join media_types mt on m.media_type_id = mt.id
group by u.id, mt.id
order by name, count desc;