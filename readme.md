### Базы данных и SQL (семинары)

<details class="desc"><summary>Урок 1. Установка СУБД, подключение к БД, просмотр и создание таблиц</summary>

[Работа во время семинара][work1]\
[Домашнее задание][home1]

```text
1. Создайте таблицу с мобильными телефонами, используя графический интерфейс. Заполните БД данными
2. Выведите название, производителя и цену для товаров, количество которых превышает 2
3. Выведите весь ассортимент товаров марки “Samsung”
4. Выведите информацию о телефонах, где суммарный чек больше 100 000 и меньше 145 000**

*** С помощью регулярных выражений найти (можно использовать операторы “LIKE”, “RLIKE” для 4.3):
4.1. Товары, в которых есть упоминание "Iphone"
4.2. "Galaxy"
4.3. Товары, в которых есть ЦИФРЫ
4.4. Товары, в которых есть ЦИФРА "8"
```

</details>
<details class="desc"><summary>Урок 2. SQL – создание объектов, простые запросы выборки</summary>

[Работа во время семинара][work2]\
~~[Домашнее задание][home2]~~

```text
1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными
2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.
3. Создайте таблицу “orders”, заполните ее значениями. Покажите “полный” статус заказа, используя оператор CASE

Дополнительное задание к первым 2 урокам:
1. CRUD - операции на любом ЯП. Коннект с БД через С#, к примеру

Файл со скриптом прикреплен к материалам(interview.sql):
№1. Используя оператор ALTER TABLE, установите внешний ключ в одной из таблиц (clients-posts)
№2. Без оператора JOIN, верните заголовок публикации, текст с описанием, идентификатор клиента, опубликовавшего публикацию и логин данного клиента.
№3. Выполните поиск по публикациям, автором которых является клиент "Mikle".
```

</details>
<details class="desc" style="display: none"><summary>Стили для IDE</summary>

<style>
.desc {
    margin: 0 0 0 1em;
    padding: 0 0 1em;
}
.desc summary {
    margin: 0 0 -1em;
    list-style-position: outside;
    cursor: pointer;
    
}
.desc pre {
    border: 1px solid #37b;
    margin: -1em 0 1.5em;
    padding: 0.3em 0.6em;
}
</style>

</details>

[link]: https://github.com/crasher307/database/blob/master/

[work1]: lesson1/work.sql
[//]: # ([work1]: https://github.com/crasher307/database/blob/master/lesson1/work.sql)
[home1]: https://github.com/crasher307/database/blob/master/lesson1/homework.sql
[work2]: https://github.com/crasher307/database/blob/master/lesson2/work.sql
[home2]: https://github.com/crasher307/database/blob/master/lesson2/homework.sql