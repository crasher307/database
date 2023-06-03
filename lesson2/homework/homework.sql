create database if not exists gb_2;
use gb_2;

# 1
drop table if exists sales;
create table sales
(
    id            int(16) primary key auto_increment,
    order_date    date   default null,
    count_product int(8) default 0
) auto_increment = 0;

create trigger bi_sales
    before insert
    on sales
    for each row
begin
    SET NEW.order_date = NOW();
end;
insert into sales (order_date, count_product)
values ('2022-01-01', 156),
       ('2022-01-02', 180),
       ('2022-01-03', 21),
       ('2022-01-04', 124),
       ('2022-01-05', 341);

# 2
select id,
       case
           when count_product < 100 then 'Маленький заказ'
           when count_product between 100 and 300 then 'Средний заказ'
           when count_product > 300 then 'Большой заказ'
           end as 'Тип заказа'
from sales;
# OR
select case
           when count_product < 100 then 'Маленький заказ'
           when count_product between 100 and 300 then 'Средний заказ'
           when count_product > 300 then 'Большой заказ'
           end            as type,
       SUM(count_product) as count_product
from sales
group by type;

# 3
drop table if exists orders;
create table orders
(
    id           int(16) primary key auto_increment,
    employee_id  varchar(8) not null,
    amount       decimal(8, 2) default 0,
    order_status varchar(16)   default 'OPEN'
) auto_increment = 0;
insert into orders (employee_id, amount, order_status)
values ('e03', 15.00, 'OPEN'),
       ('e01', 25.50, 'OPEN'),
       ('e05', 100.70, 'CLOSED'),
       ('e02', 22.18, 'OPEN'),
       ('e04', 9.50, 'CANCELLED');

select *,
       case
           when order_status = 'open' then 'Order is in open state'
           when order_status = 'closed' then 'Order is closed'
           when order_status = 'cancelled' then 'Order is cancelled'
           end as full_order_status
from orders;

# 4
/*
C# -> int? number = null; // (int + null)
C# -> int number = 0; // (int)
C# -> int number = null; // error

0 - тип INT, не может принимать значение NULL
null - тип NULL, отсутствие значения (не инициализированная переменная)
*/

# 5
# №1. Используя оператор ALTER TABLE, установите внешний ключ в одной из таблиц (clients-posts)
alter table posts
    add constraint fk_posts_user_id foreign key (user_id) references users (id);
# №2. Без оператора JOIN, верните заголовок публикации, текст с описанием, идентификатор клиента, опубликовавшего публикацию и логин данного клиента.
select p.title, p.full_text, p.user_id, u.login
from posts p,
     users u
where u.id = p.user_id;
# №3. Выполните поиск по публикациям, автором которых является клиент "Mikle".
select p.*
from posts p
         left join users u on u.id = p.user_id
where u.login = 'Mikle';