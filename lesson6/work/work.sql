create database if not exists gb_6;
USE gb_6;

select *
from staff;

drop procedure if exists get_status;
delimiter $$
create procedure get_status(
    in staff_number int, # номер человека, не может меняться
    out staff_status varchar(64) # статус человека, может меняться
)
begin
    declare staff_salary double; # null
    select salary
    into staff_salary
    from staff
    where id = staff_number;

    if staff_salary < 50000 then
        set staff_status = 'Средняя зарплата';
    elseif staff_salary between 50000 and 69999 then
        set staff_status = 'ЗП выше средней';
    elseif staff_salary >= 70000 then
        set staff_status = 'Высокая зарплата';
    end if;
end $$
delimiter ;

# Вызов процедуры
call get_status(4, @res_out);

select *, @res_out
from staff
where id = 4;

# ---
drop function if exists get_age;
delimiter $$;
create function get_age(
    date_birth date, # Y-M-D - 2023-06-04
    current_t datetime # Y-M-D H:m:s - 2023-06-04 10:55:05
)
    returns int
    deterministic
    return (year(current_t) - year(date_birth));
delimiter ;

select get_age('1983-06-04', now()) as 'Возраст человека';

# ПРОЦЕДУРЫ
# создание процедуры для добавления нового пользователя с профилем c определение COMMIT или ROLLBACK

drop procedure if exists user_add;
delimiter $$;
create procedure user_add(
    # users
    p_firstname varchar(50), p_lastname varchar(50), p_email varchar(120),
    # profiles
    p_hometown varchar(100), p_photo_id int, p_birthday date,
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
    insert into users(firstname, lastname, email) values (p_firstname, p_lastname, p_email);
    insert into profiles(user_id, birthday, photo_id, hometown) values (last_insert_id(), p_birthday, p_photo_id, p_hometown);
    if _rollback then
        set result = concat('Error ', err_code, ': ', err_message);
        rollback; # откат
    else
        set result = 'OK';
        commit; # сохранение
    end if;
end $$;
delimiter ;

call user_add('New', 'User', 'new_user@gmail.com', 'Moscow', -1, '1998-01-01', @proced_result);
select @proced_result;
call user_add('New', 'User', 'new_user@gmail.com', 'Moscow', null, '1998-01-01', @proced_result);
select @proced_result;

# ---
DROP PROCEDURE IF EXISTS print_numbers;
DELIMITER $$
CREATE PROCEDURE print_numbers(
    input_number INT -- N
)
BEGIN
    DECLARE n INT; -- n = input_number
    DECLARE result VARCHAR(45) DEFAULT '';

    SET n = input_number;
    REPEAT
        SET result = CONCAT(result, n, ',');
        SET n = n - 1;

    UNTIL n <= 0 -- Условие выхода из цикла
        -- Если у вас n - отр или ноль
        END REPEAT;
    SELECT result;
END $$

-- Вызов процедуры
CALL print_numbers(7); -- N = 7
