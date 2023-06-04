use gb_4;

# 1-1
select s.shopname, c.name
from cats c
         left join shops s on s.id = c.shops_id
order by s.shopname;

# 1-2
select s.shopname
from shops s
         left join cats c on s.id = c.shops_id
where c.name = 'Murzik';

select shopname
from shops
where id in (select shops_id from cats where name = 'Murzik');

# 1-3
select *
from shops
where id not in (select shops_id from cats where name in ('Murzik', 'Zuza'));


# 2-1
select a.an_name as 'name', a.an_price as 'price', min(o.ord_datetime) as 'from', max(o.ord_datetime) as 'to'
from analysis a
         left join orders o on a.an_id = o.ord_an
where o.ord_datetime between '2020-02-05' and '2020-02-12'
group by a.an_name, a.an_price
order by `from` desc, `to` desc;