create database if not exists gb_5;
use gb_5;
drop table if exists cars;
create table cars
(
    id   int not null primary key,
    name varchar(45),
    cost int
);
insert cars
values (1, 'Audi', 52642),
       (2, 'Mercedes', 57127),
       (3, 'Skoda', 9000),
       (4, 'Volvo', 29000),
       (5, 'Bentley', 350000),
       (6, 'Citroen', 21000),
       (7, 'Hummer', 41400),
       (8, 'Volkswagen', 21600);
drop table if exists trains;
create table if not exists trains
(
    id           int(16) primary key auto_increment,
    train_id     int(16),
    station      varchar(20),
    station_time time
);
insert into trains(train_id, station, station_time)
values (110, 'San Francisco', '10:00:00'),
       (110, 'Redwood City', '10:54:00'),
       (110, 'Palo Alto', '11:02:00'),
       (110, 'San Jose', '12:35:00'),
       (120, 'San Francisco', '11:00:00'),
       (120, 'Palo Alto', '12:49:00'),
       (120, 'San Jose', '13:30:00');