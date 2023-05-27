# 1. Создание БД
CREATE DATABASE IF NOT EXISTS gb_1;
# Создать БД, если не существует
# 2. Подключение
USE gb_1;
# Подключиться к БД
# 3. Создание таблицы
DROP TABLE IF EXISTS users; # Удалить таблицу, если существует
CREATE TABLE users # Создать таблицу
(
    # имя тип_данных ограничения
    `id`       INT(16) PRIMARY KEY AUTO_INCREMENT,
    `username` VARCHAR(32) UNIQUE NOT NULL COMMENT 'Имя пользователя (логин)',
    `password` VARCHAR(64)        NOT NULL COMMENT 'Хэш пароля',
    `email`    VARCHAR(64)        NOT NULL COMMENT 'Эл. почта',
    `phone`    VARCHAR(11)        NULL COMMENT 'Номер телефона',
    `active`   BOOLEAN            NOT NULL DEFAULT TRUE COMMENT 'Активность'
) AUTO_INCREMENT = 0;
# ALTER TABLE users AUTO_INCREMENT = 100; # Изменение таблицы
# 4. Добавление данных в таблицу
INSERT INTO users(`username`, `password`, `email`, `phone`) # Добавление записи в таблицу
VALUES ('admin', 'password_hash', 'admin@test.tt', ''),
       ('test', 'password_hash', 'test@test.tt', '9997770001'),
       ('test2', 'password_hash', 'test2@test.tt', '9997770002');
# 5. Обновление данных
UPDATE users
SET `password` = '',
    `active`   = false
WHERE `username` = 'admin';
# Обновление записи в таблице
# 6. Выборка
# SELECT * FROM users LIMIT 10; # Вывод всех данных
# SELECT username, email, phone FROM users WHERE username='test;
SELECT *
FROM users
WHERE username LIKE 'test%';