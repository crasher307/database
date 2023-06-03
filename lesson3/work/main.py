import pymysql

from config import host, username, password, base

try:
    connection = pymysql.connect(
        host=host,
        port=3306,
        user=username,
        password=password,
        database=base,
        cursorclass=pymysql.cursors.DictCursor
    )
    print("Successfully connected")

    try:
        cursor = connection.cursor()

        # create table
        create_query = "CREATE TABLE IF NOT EXISTS test" \
                       "(id INT PRIMARY KEY AUTO_INCREMENT," \
                       "firstname VARCHAR(45));"
        cursor.execute(create_query)
        print("Table created successfully")

        # insert data
        insert_query = "INSERT test (firstname) VALUES ('Михаил'), ('Маша');"
        cursor.execute(insert_query)
        print("Insert successfully")
        connection.commit()  # save to db

        # update
        cursor.execute("UPDATE test SET firstname='new name' WHERE firstname='Маша';")
        connection.commit()  # save to db

        # delete
        cursor.execute("DELETE FROM test WHERE firstname='new name';")
        connection.commit()  # save to db

        # select
        cursor.execute("SELECT * FROM test;")
        rows = cursor.fetchall()
        for row in rows:
            print(row)
    finally:
        connection.close()
except Exception as e:
    print(f"Error: {e}")
