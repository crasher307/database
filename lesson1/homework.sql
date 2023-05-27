# 1
create database if not exists gb_1;
use gb_1;
drop table if exists phones;
create table phones
(
    `id`            int(16) primary key auto_increment,
    `phone_name`    varchar(32) comment 'Модель',
    `manufacturer`  varchar(32) comment 'Производитель',
    `product_count` int(8) comment 'Кол-во',
    `price`         int(8) comment 'Цена (шт)'
) auto_increment = 0;
insert into phones (phone_name, manufacturer, product_count, price)
values ('iPhone X', 'Apple', 3, 76000),
       ('iPhone 8', 'Apple', 2, 51000),
       ('Galaxy S9', 'Samsung', 2, 56000),
       ('Galaxy S8', 'Samsung', 1, 41000),
       ('P20 Pro', 'Huawei', 5, 36000);

# 2
select phone_name, manufacturer, price
from phones
where product_count > 2;

# 3
select *
from phones
where manufacturer = 'Samsung';

# 4
# (fast, 1 request)
select *, (price * product_count) as total
from phones
where (price * product_count) between 100000 and 145000;
# (slow, 2 request - select all rows)
select *
from (select *, (price * product_count) as total from phones) p
where total between 100000 and 145000;
# (fast, 2 request)
select p.*, @total as total
from phones p,
     (select @total := 0) t
where id in (select id
             from phones
             where (@total := price * product_count) between 100000 and 145000);

# 4.1
select *
from phones
where phone_name like '%iphone%';
# 4.2
select *
from phones
where phone_name like '%galaxy%';
# 4.3
select *
from phones
where phone_name rlike '[0-9]+';
# 4.4
select *
from phones
where phone_name rlike '8+';