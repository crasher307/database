use gb_3;

# 1
select *
from staff
order by salary;
select *
from staff
order by salary desc;

# 2
select *
from staff
order by salary desc
limit 5;

# 3
select post, sum(salary) as 'sum'
from staff
group by post;

# 4
select count(id)
from staff
where post = 'Рабочий'
  and age between 24 and 49;

# 5
select count(distinct post) as count
from staff;

# 6
select post, avg(age) as avg_age
from staff
group by post
having avg_age < 30;