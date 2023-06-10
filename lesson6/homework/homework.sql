create database if not exists gb_6;
USE gb_6;

# 1
drop procedure if exists test;
delimiter $$
create procedure test(in second int(16), out result varchar(300))
begin
    set result = date_format(
            sec_to_time(second),
            concat(round(second / 86400), ' days %H hours %i minutes %s seconds')
        );
end $$;
delimiter ;
call test(123456, @proced_result);
select @proced_result;

# 2
drop procedure if exists test2;
delimiter $$
create procedure test2(out result varchar(300))
begin
    declare _cnt int default 1;
    set result = '';
    while _cnt <= 10
        do
            set result = if(_cnt % 2 = 0, if(result = '', _cnt, concat(result, ',', _cnt)), result);
            set _cnt = _cnt + 1;
        end while;
end $$;
delimiter ;
call test2(@proced_result);
select @proced_result;

# -----------------------------------------------------------------------------------------
# ДЗ (из презентации)
# 1
drop table if exists users_old;
create table users_old
(
    id        serial primary key, # SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname varchar(50) comment 'Имя',
    lastname  varchar(50) comment 'Фамилия',
    email     varchar(120) unique
) auto_increment = 0;

drop procedure if exists remove_user;
delimiter $$
create procedure remove_user(
    in user_id int,
    # out
    out result varchar(300)
)
begin
    declare _rollback bit default 0; # rollback - откат, commit - сохранить
    declare err_code char(5); # код ошибки
    declare err_message varchar(512); # текст ошибки
    declare continue handler for sqlexception begin
        set _rollback = 1;
        get stacked diagnostics condition 1
            err_code = returned_sqlstate, err_message = message_text;
    end;

    start transaction; # начало транзакции

    if (select id from users where id = user_id) is null then
        set result = 'Пользователь не найден';
        rollback;
    else
        insert into users_old select * from users where id = user_id;
        delete from users where id = user_id;
        if _rollback then
            set result = concat('Error ', err_code, ': ', err_message);
            rollback; # откат
        else
            set result = 'OK';
            commit; # сохранение
        end if;
    end if;
end $$;
delimiter ;

call user_add('New', 'User', 'new_user2@gmail.com', null, null, '1995-02-01', @proced_result);
select @proced_result;
call remove_user((select id
                  from users
                  where email = 'new_user@gmail.com'
                  limit 1), @proced_result);
select @proced_result;

# 2
drop procedure if exists hello;
delimiter $$
create procedure hello(out result varchar(300))
begin
    set @time = time(now());
    set result = case
                     when @time between '06:00:00' and '11:59:59' then 'Доброе утро'
                     when @time between '12:00:00' and '17:59:59' then 'Добрый день'
                     when @time between '18:00:00' and '23:59:59' then 'Добрый вечер'
                     else 'Доброй ночи'
        end;
end $$;
delimiter ;
call hello(@proced_result);
select @proced_result;

# 3
drop table if exists logs;
create table logs
(
    id          bigint primary key auto_increment,
    table_name  varchar(32)             not null,
    table_pk_id bigint                  not null,
    created_at  timestamp default now() not null
) engine = archive
  default charset = utf8
  auto_increment = 0;

drop trigger if exists ai_users_log;
create trigger ai_users_log
    after insert
    on users
    for each row
begin
    insert into logs(table_name, table_pk_id) values ('users', NEW.id);
end;
drop trigger if exists ai_communities_log;
create trigger ai_communities_log
    after insert
    on communities
    for each row
begin
    insert into logs(table_name, table_pk_id) values ('communities', NEW.id);
end;
drop trigger if exists ai_messages_log;
create trigger ai_messages_log
    after insert
    on messages
    for each row
begin
    insert into logs(table_name, table_pk_id) values ('messages', NEW.id);
end;