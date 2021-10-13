# Apache2

## find webroot
[Find out webroot in running apache 2](https://stackoverflow.com/questions/27232596/find-out-webroot-in-running-apache-2)

```sh
grep -r DocumentRoot /etc/{apache,http}* 2>/dev/null
```
Result:

```
/etc/apache2/sites-available/redmine-le-ssl.conf:    DocumentRoot /home/redmine/redmine/public
/etc/apache2/sites-available/default-ssl.conf:          DocumentRoot /var/www/html
/etc/apache2/sites-available/000-default.conf:  DocumentRoot /var/www/html
/etc/apache2/sites-available/redmine.conf:    DocumentRoot /home/redmine/redmine/public
```
