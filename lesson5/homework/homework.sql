create database if not exists gb_5;
use gb_5;

# 1
create or replace view cost_max as select * from cars where cost < 25000;
select * from cost_max;

# 2
alter view cost_max as select * from cars where cost < 30000;
select * from cost_max;

# 3
create or replace view skoda_audi as select * from cars where name in ('Skoda', 'Audi');
select * from skoda_audi;

# 4
select *,
       timediff(
           lead(station_time) over (partition by train_id order by station_time),
           trains.station_time
           ) as time_to_next_station
from trains;