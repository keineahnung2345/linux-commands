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
