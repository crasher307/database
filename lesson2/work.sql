CREATE DATABASE IF NOT EXISTS gb_2; # Создание БД
USE gb_2; # Подключиться к БД
DROP TABLE IF EXISTS movie;
# Удалить таблицу, если существует
# Создать таблицу
CREATE TABLE movie
(
    id           int(16) primary key auto_increment, # PRIMARY KEY = UNIQUE NOT NULL
    title        varchar(64) not null comment 'Название (рус.)',
    # char - строка постоянной длины (неисп. сим. заполняются пробелами),
    # varchar - переменной длины (меняет длину, экономит память сервера)
    title_en     varchar(64) comment 'Название (англ.)',
    release_year year comment 'Год выхода',          # YEAR = 4 символа
    count_min    int(3) comment 'Продолжительность',
    storyline    text comment 'Описание'
) AUTO_INCREMENT = 0;
# Добавить записи в таблицу
insert into movie (title, title_en, release_year, count_min, storyline)
values ('Игры разума', 'A Beautiful Mind', 2001, 135,
        'От всемирной известности до греховных глубин — все это познал на своей шкуре Джон Форбс Нэш-младший. Математический гений, он на заре своей карьеры сделал титаническую работу в области теории игр, которая перевернула этот раздел математики и практически принесла ему международную известность. Однако буквально в то же время заносчивый и пользующийся успехом у женщин Нэш получает удар судьбы, который переворачивает уже его собственную жизнь.'),
       ('Форрест Гамп', 'Forrest Gump', 1994, 142,
        'Сидя на автобусной остановке, Форрест Гамп — не очень умный, но добрый и открытый парень — рассказывает случайным встречным историю своей необыкновенной жизни. С самого малолетства парень страдал от заболевания ног, соседские мальчишки дразнили его, но в один прекрасный день Форрест открыл в себе невероятные способности к бегу. Подруга детства Дженни всегда его поддерживала и защищала, но вскоре дороги их разошлись.'),
       ('Иван Васильевич меняет профессию', NULL, 1998, 128,
        'Инженер-изобретатель Тимофеев сконструировал машину времени, которая соединила его квартиру с далеким шестнадцатым веком - точнее, с палатами государя Ивана Грозного. Туда-то и попадают тезка царя пенсионер-общественник Иван Васильевич Бунша и квартирный вор Жорж Милославский. На их место в двадцатом веке «переселяется» великий государь. Поломка машины приводит ко множеству неожиданных и забавных событий...'),
       ('Назад в будущее', 'Back to the Future', 1985, 116,
        'Подросток Марти с помощью машины времени, сооружённой его другом-профессором доком Брауном, попадает из 80-х в далекие 50-е. Там он встречается со своими будущими родителями, ещё подростками, и другом-профессором, совсем молодым.'),
       ('Криминальное чтиво', 'Pulp Fiction', 1994, 154, NULL);


#   DDL: CREATE, DROP, ALTER, RENAME, TRUNCATE(очистка таблицы от данных)
#   DML: SELECT, INSERT, UPDATE, DELETE
# Удалить таблицу, если существует
DROP TABLE IF EXISTS film;
# Переименовать таблицу
rename table movie to film;
# Отобразить список всех таблиц в БД
# show full tables;
# Добавление столбцов
alter table film
    add test  int(6) default 100 after count_min, # ADD = ADD COLUMN
    add price int(6) default 250 after test;
# Удаление столбца
alter table film
    drop test;
# Очистка данных таблицы
# truncate film;
# Обновление данных
update film
set price=price + 150
where title = 'Иван Васильевич меняет профессию';
#Удаление данных
delete
from film
where title = 'Криминальное чтиво';


# Добавить столбец, в кот. хран. статус оплаты (0 - не оплачено, 1 - онлайн)
alter table film
    add payment_status tinyint(1) after price;
update film
set payment_status = rand()
where payment_status is null;
# Диапазон [0..1]


# CASE
select id,
       title          as 'Название_рус',
       payment_status as 'Статус_оплаты',
       case
           when payment_status = 0
               then 'Не оплачен'
           when payment_status = 1
               then 'Оплачен онлайн'
           else 'Ошибка оплаты'
           end        as 'Комментарий'
from film;
# select floor(rand() * 100 - rand() * rand() * 5);
# select floor(2.5);
# select ceiling(2.5);


# IF (условие, valTrue, valFalse)
# Types
#   < 50 - короткометражка
#   50-140 - среднеметражка
#   141-150 - полнометражка
#   150+ - "в кино не идем"
select title,
       count_min,
       if(count_min < 50, 'короткометражка',
          if(count_min between 50 and 140, 'среднеметражка',
             if(count_min >= 150, 'полнометражка', 'в кино не идем')
              )
           ) as 'Тип_фильма'
from film;


# select * from film;