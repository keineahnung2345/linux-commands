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

Show description of a table:
```sql
DESC[RIBE] mytable;
```

Create table:
```sql
CREATE TABLE mytable(phone char(11) primary key, buy_time timestamp);
```

Copy table:

[SQL Cloning Tables](https://www.tutorialrepublic.com/sql-tutorial/sql-cloning-tables.php)
```sql
CREATE TABLE mytable2 SELECT * FROM mytable;
```

Delete table:
```sql
DROP TABLE [IF EXISTS] mytable;
```

Rename table:
```sql
RENAME TABLE mytable2 TO mytable;
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

Add column:
```sql
ALTER TABLE mytable ADD COLUMN sex BOOLEAN;
```

Change column's data type:

[How do I change the data type for a column in MySQL?](https://stackoverflow.com/questions/1356866/how-do-i-change-the-data-type-for-a-column-in-mysql)
```sql
ALTER TABLE mytable MODIFY embedding_1 INTEGER [NOT NULL];
```

For a timestamp column, Remove `on update CURRENT_TIMESTAMP` and default `CURRENT_TIMESTAMP`:

[How do I remove ON UPDATE CURRENT_TIMESTAMP from an existing column?](https://stackoverflow.com/questions/31839542/how-do-i-remove-on-update-current-timestamp-from-an-existing-column)

```sql
-- to remove "on update CURRENT_TIMESTAMP" from Extra
ALTER TABLE mytable CHANGE COLUMN buy_time buy_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;
-- to remove "CURRENT_TIMESTAMP" from Default
ALTER TABLE mytable ALTER COLUMN buy_time DROP DEFAULT;
```

## Query
### Count
```sql
SELECT COUNT(*) from mytable;
```

### Max
```sql
SELECT MAX(buy_time) AS latest FROM mytable;
```

### Operation on columns
```sql
SELECT width * height AS area FROM rectangle;
```

### Concat
```sql
SET @a="abc";
CALL DebugMessage(TRUE, CONCAT(@a, "def")); -- abcdef
-- note that the variable 'b' is not declared
CALL DebugMessage(TRUE, CONCAT(@a, "def", @b)); -- NULL
```

To ignore `NULL` value automatically([MySQL CONCAT returns NULL if any field contain NULL](https://stackoverflow.com/questions/15741314/mysql-concat-returns-null-if-any-field-contain-null)):
```sql
CALL DebugMessage(TRUE, CONCAT(@a, "def", COALESCE(@b,""))); -- abcdef
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
UPDATE mytable SET sex=TRUE WHERE phone=12345678901;
UPDATE mytable SET sex=0 WHERE phone=12345678902;
```

### DISTINCT
```sql
SELECT DISTINCT phone FROM mytable WHERE embedding_1 < 0.01;
```

### GROUP BY
Note that it's `GROUP BY`, not `GROUPBY`.
```sql
SELECT sex, COUNT(*) FROM mytable GROUP BY sex;
```

### Time
Date:
```sql
SELECT CURRENT_DATE();
```
Time:
```sql
SELECT CURRENT_TIME();
```
Timestamp(Date + Time):
```sql
SELECT CURRENT_TIMESTAMP();
```
Use as subquery:
```sql
INSERT INTO mytable VALUES("12345678902", CURRENT_TIMESTAMP());
```

### SubQuery
[MySQL SubQuery Tutorial with Examples](https://www.guru99.com/sub-queries.html)

Query from 2 different tables:
```sql
SELECT phone, buy_time FROM mytable WHERE (phone, buy_time) IN 
    (SELECT phone, buy_time FROM mytable2 WHERE sex =0);
```
Get the record count of the phones who contain at least one record of embedding_1 < 0.01.
```sql
SELECT phone, COUNT(*) AS ALL_COUNT FROM mytable WHERE phone IN 
    (SELECT DISTINCT phone FROM mytable WHERE embedding_1 < 0.01)
GROUP BY phone;
```

### Variable
Set variable

[How to declare a variable in MySQL?](https://stackoverflow.com/questions/11754781/how-to-declare-a-variable-in-mysql)
```sql
SET @a="abc";
```

[How to store Query Result in variable using mysql](https://stackoverflow.com/questions/10070406/how-to-store-query-result-in-variable-using-mysql)

Store the query result into a variable.
```sql
SELECT @latest := MAX(buy_time) FROM mytable;
SELECT @latest;
```

### Derived table(Subquery in the FROM clause)
[An Essential Guide to MySQL Derived Table](https://www.mysqltutorial.org/mysql-derived-table/) and [Using A Subquery in the FROM clause](https://www.essentialsql.com/get-ready-to-learn-sql-server-22-using-subqueries-in-the-from-clause/)

First find the phones containing at least one record meeting embedding_1 < 0.01, and then calculate the ratio of records meeting this requirement for each phone.
```sql
SELECT T1.phone, T1.VALID_COUNT/T2.ALL_COUNT AS RATIO FROM 
    (SELECT phone, COUNT(*) AS VALID_COUNT FROM mytable WHERE (phone, buy_time) IN (SELECT phone, buy_time FROM mytable WHERE embedding_1 < 0.01) GROUP BY phone) T1,  
    (SELECT phone, COUNT(*) AS ALL_COUNT FROM mytable WHERE phone in (SELECT DISTINCT phone FROM mytable WHERE embedding_1 < 0.01) GROUP BY phone) T2 
WHERE T1.phone = T2.phone;
```

### Temporary table
[Create a temporary table in a SELECT statement without a separate CREATE TABLE](https://stackoverflow.com/questions/5859391/create-a-temporary-table-in-a-select-statement-without-a-separate-create-table)

Store the query result into a temp table, this can be used to simplify nested query.
```sql
CREATE TEMPORARY TABLE IF NOT EXISTS T1 AS (<another_query>);
```
Using temporary table, the example in `Derived table` can be simplified as:
```sql
CREATE TEMPORARY TABLE IF NOT EXISTS T1 AS (SELECT phone, count(*) AS VALID_COUNT FROM mytable WHERE embedding_1 < 0.01 GROUP BY phone);
CREATE TEMPORARY TABLE IF NOT EXISTS T2 AS (SELECT phone, COUNT(*) AS ALL_COUNT FROM mytable WHERE phone in (SELECT DISTINCT phone FROM mytable WHERE embedding_1 < 0.01) GROUP BY phone);
SELECT T1.phone, T1.VALID_COUNT/T2.ALL_COUNT AS RATIO FROM T1, T2 WHERE T1.phone = T2.phone;
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

Edit the stored procedure used for debugging `debug_msg.sql`:

[How do you debug MySQL stored procedures?](https://stackoverflow.com/questions/273437/how-do-you-debug-mysql-stored-procedures)
```sql
DELIMITER $$
DROP PROCEDURE IF EXISTS `DebugMessage`$$
CREATE PROCEDURE DebugMessage(enabled INTEGER, msg VARCHAR(255))
BEGIN
  IF enabled THEN
    select concat('** ', msg) AS '** DEBUG:';
  END IF;
END $$
```

Edit the stored procedure used for looping through columns `loop_columns.sql` and multiply each column by 1000:

[mysql, iterate through column names](https://stackoverflow.com/questions/4950252/mysql-iterate-through-column-names)
```sql
DELIMITER $$
DROP PROCEDURE IF EXISTS LoopColumns$$
CREATE PROCEDURE LoopColumns()
BEGIN
DECLARE i INT DEFAULT 1;
DECLARE col_name VARCHAR(100) DEFAULT '';
DECLARE col_names CURSOR FOR
  SELECT column_name
  FROM INFORMATION_SCHEMA.COLUMNS
  WHERE table_name = 'mytable'
  ORDER BY ordinal_position;
-- https://stackoverflow.com/questions/4955231/cursor-not-open-error
OPEN col_names;

the_loop: REPEAT
    FETCH col_names INTO col_name;

    -- the first 2 column of mytable is phone and buy_time, last 128s are embedding_x
    IF i < 3 THEN
        SET i = i + 1;
        ITERATE the_loop;
    END IF;
    SET @s = CONCAT('UPDATE mytable SET ', COALESCE(col_name, ''), '=', COALESCE(col_name, ''), '*1000');

    PREPARE stmt FROM @s;
    EXECUTE stmt;

    SET i = i + 1;
UNTIL i > 130
END REPEAT;
CLOSE col_names;
END
$$
DELIMITER ;
```

To run it, from [How to create a mysql stored procedure through linux terminal](https://dba.stackexchange.com/questions/41336/how-to-create-a-mysql-stored-procedure-through-linux-terminal?newreg=b13a7c3337fa4f918f22ddedc3d29579):
```sh
mysql -u root -p<password> <mydb> < <sql_file_name>.sql
```

To run stored procedure in mysql shell([Execute MySQL Stored Procedure using Command Line](https://stackoverflow.com/questions/3828341/execute-mysql-stored-procedure-using-command-line)):
```sql
CALL DebugMessage(TRUE, "ABC");
```

This sample use 128 columns to store a vector, for an alternative way, try [How do I create a field with a vector type in MySQL?](https://stackoverflow.com/questions/24346424/how-do-i-create-a-field-with-a-vector-type-in-mysql).
