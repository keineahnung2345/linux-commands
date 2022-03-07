# PostgreSQL

## install

[Ubuntu 20.04下安裝Postgresql](https://blog.csdn.net/keineahnung2345/article/details/115897265)

## check version

[How to View Which Postgres Version is Running](https://chartio.com/resources/tutorials/how-to-view-which-postgres-version-is-running/)

```sh
/usr/lib/postgresql/12/bin/psql -V
```

Or simply:

```
psql -V
```

Result:
```
psql (PostgreSQL) 12.10 (Ubuntu 12.10-1.pgdg20.04+1)
```


## connection to server at "localhost" (127.0.0.1), port 5432 failed: Connection refused

[Is the server running on host "localhost" (::1) and accepting TCP/IP connections on port 5432?](https://stackoverflow.com/questions/37307346/is-the-server-running-on-host-localhost-1-and-accepting-tcp-ip-connections)

If seeing this error message in passenger's log(`/tmp/passenger-error-*.html`):

```
Error: The application encountered the following error: connection to server at "localhost" (127.0.0.1), port 5432 failed: Connection refused
	Is the server running on that host and accepting TCP/IP connections?
connection to server at "localhost" (::1), port 5432 failed: Cannot assign requested address
	Is the server running on that host and accepting TCP/IP connections?
 (PG::ConnectionBad)
```

It can be solved by:

```sh
service postgresql restart
```
