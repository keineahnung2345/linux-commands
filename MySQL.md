# MySQL
[Install MySQL Server on the Ubuntu operating system](https://support.rackspace.com/how-to/install-mysql-server-on-the-ubuntu-operating-system/)
## Installation
```sh
sudo apt-get update
sudo apt-get install mysql-server
```

## Start service
```sh
sudo systemctl start mysql
```

## Check version
```sh
mysql -V
```

## Start shell
```sh
mysql -u root -p
```

## Database
Show databases:
```sql
SHOW DATABASES;
```

Create database:
```sql
CREATE DATABASE mydb;
```

## Table
First we need to select the database to use:
```sql
USE mydb;
```

Show tables:
```sql
SHOW TABLES;
```

Create table:
```sql
CREATE TABLE mytable(phone char(11), buy_time timestamp);
```

Show columns:
```sql
SHOW COLUMNS FROM mytable;
```

Set column(s) as primary key:
[MySQL Primary Key](https://www.mysqltutorial.org/mysql-primary-key/)
```sql
ALTER TABLE mytable ADD PRIMARY KEY(phone, buy_time);
```

## Query
### Count
```sql
SELECT COUNT(*) from mytable;
```

### Insert
```sql
INSERT INTO mytable VALUES (12345678901, FROM_UNIXTIME(1578635060), 3.000000, 3.000000);
```

### Delete
```sql
DELETE FROM mytable WHERE phone=12345678901;
```
Delete all:
```sql
DELETE FROM mytable;
```
[How to delete a MySQL record after a certain time](https://stackoverflow.com/questions/14096429/how-to-delete-a-mysql-record-after-a-certain-time)
```sql
DELETE FROM mytable WHERE buy_time < (CURDATE() - INTERVAL 2 DAY);
```
Delete by some order([mysql deleting oldest record in a table](https://stackoverflow.com/questions/20093361/mysql-deleting-oldest-record-in-a-table)), this delete the earliest buying record of "9876543210":
```sql
DELETE FROM mytable WHERE phone = 9876543210 ORDER BY buy_time ASC LIMIT 1;
```

### Update
```sql
UPDATE mytable SET phone=09876543210 WHERE phone=12345678901;
```

## Stored procedure
This stored procedure add 128 columns named `embedding_1` to `embedding_128` to `mytable`. (Adapted from [Add columns to mySQL table with loops](https://stackoverflow.com/questions/14313418/add-columns-to-mysql-table-with-loops) and [MySQL REPEAT Loop](https://www.mysqltutorial.org/mysql-stored-procedure/mysql-repeat-loop/) and [Dynamic add column with loop](https://stackoverflow.com/questions/20108188/dynamic-add-column-with-loop) and [How To have Dynamic SQL in MySQL Stored Procedure](https://stackoverflow.com/questions/190776/how-to-have-dynamic-sql-in-mysql-stored-procedure)).

Edit `addcolumns.sql`:
```sql
DELIMITER $$
DROP PROCEDURE IF EXISTS AddColumns$$
CREATE PROCEDURE AddColumns()
BEGIN
    DECLARE counter INT DEFAULT 1;
    DECLARE result VARCHAR(100) DEFAULT '';

    REPEAT
        SET result = '';
        SET result = CONCAT(result,'embedding_',counter);
        SET counter = counter + 1;
        SET @sql = CONCAT('ALTER TABLE mytable ADD ',result,' float');
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    UNTIL counter > 128
    END REPEAT;

    -- display result
    SELECT result;
END
$$
DELIMITER ;
```

To run it, from [How to create a mysql stored procedure through linux terminal](https://dba.stackexchange.com/questions/41336/how-to-create-a-mysql-stored-procedure-through-linux-terminal?newreg=b13a7c3337fa4f918f22ddedc3d29579):
```sh
mysql -u root -p<password> <mydb> < addcolumns.sql
```

This sample use 128 columns to store a vector, for an alternative way, try [How do I create a field with a vector type in MySQL?](https://stackoverflow.com/questions/24346424/how-do-i-create-a-field-with-a-vector-type-in-mysql).
