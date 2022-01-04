# Apache2
## important paths of Apache2
```
/etc/apache2                  #apache2.conf, ports.conf
/etc/apache2/sites-available  # 000-default.conf
/var/www/html                 # index.html
/etc/ssl                      #certs, private
/var/log/apache2              #access.log  error.log  other_vhosts_access.log
```

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

## sites

enable site:
```sh
sudo a2ensite 000-default # enable the site 000-default
```

disable site:
```sh
sudo a2dissite 000-default # disable the site 000-default
```

list enabled site:
[How can I list the current Apache 2 virtual hosts from the command line?](https://serverfault.com/questions/742352/how-can-i-list-the-current-apache-2-virtual-hosts-from-the-command-line)
```sh
a2query -s
```
result:
```
redmine-le-ssl (enabled by unknown)
redmine (enabled by site administrator)
```

# modules
check enabled modules:

[How to Check Which Apache Modules are Enabled/Loaded in Linux](https://www.tecmint.com/check-apache-modules-enabled/)
```
sudo apachectl -M
```
result:
```
Loaded Modules:
 core_module (static)
 so_module (static)
 watchdog_module (static)
 http_module (static)
 log_config_module (static)
 logio_module (static)
 version_module (static)
 unixd_module (static)
 access_compat_module (shared)
 alias_module (shared)
 auth_basic_module (shared)
 authn_core_module (shared)
 authn_file_module (shared)
 authz_core_module (shared)
 authz_host_module (shared)
 authz_user_module (shared)
 autoindex_module (shared)
 deflate_module (shared)
 dir_module (shared)
 env_module (shared)
 filter_module (shared)
 mime_module (shared)
 mpm_event_module (shared)
 negotiation_module (shared)
 reqtimeout_module (shared)
 rewrite_module (shared)
 setenvif_module (shared)
 socache_shmcb_module (shared)
 ssl_module (shared)
 status_module (shared)
 passenger_module (shared)
```

Note: the `sudo` is important, otherwise it will output following error:
```
SSLCertificateFile: file '/etc/letsencrypt/live/www.xxx.com/fullchain.pem' does not exist or is empty
Action '-M' failed.
The Apache error log may have more information.
```
