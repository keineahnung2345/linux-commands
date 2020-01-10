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

## Start shell
```sh
mysql -u root -p
```

## Database
Create database
```sql
CREATE DATABASE mydb;
```

Show databases:
```sql
SHOW DATABASES;
```

## Table
```sql
CREATE TABLE mytable(phone char(11), buy_time timestamp);
```

## Stored procedure
This stored procedure add 128 columns named `embedding_1` to `embedding_128` to `mytable`. (Adapted from [Add columns to mySQL table with loops](https://stackoverflow.com/questions/14313418/add-columns-to-mysql-table-with-loops) and [MySQL REPEAT Loop](https://www.mysqltutorial.org/mysql-stored-procedure/mysql-repeat-loop/)).

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
