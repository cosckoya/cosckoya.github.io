---
hide:
  - tags

tags:
  - database
  - sysadmin
---
## MySQL
!!! Reference
    - [MySQL Dev](https://dev.mysql.com/)
    - [W3 Schools](https://www.w3schools.com/MySQL/default.asp)

???- info "Commands"
    === "Connect"
        Simple Connection String:
        ```
        shell> mysql -h <HOSTNAME> -u <USER> -p
        ```

    === "Dump"
        ```
        shell> mysqldump -h <HOSTNAME> -u <USER> <DATABASE> -p \
            --hex-blob --single-transaction --set-gtid-purged=OFF \
            --default-character-set=utf8mb4 | gzip > dump.sql.gz
        ```

    === "Import"
        ```
        shell> mysql -h <HOSTNAME> -u <USER> <DATABASE> -p < dump.sql
        ```


???- notes "MGMT Queries"
    === "Create DB & User"
        MySQL 5.x
        ```
        mysql> CREATE DATABASE cosckoyadb;
        mysql> GRANT ALL PRIVILEGES ON cosckoyadb.* TO 'cosckoya'@'%' IDENTIFIED BY 'пароль';
        mysql> FLUSH PRIVILEGES;
        ```
        MySQL 8.x
        ```sql
        mysql> CREATE DATABASE cosckoyadb;
        mysql> GRANT ALL PRIVILEGES ON cosckoyadb.* TO 'cosckoya'@'%' IDENTIFIED BY     'пароль';
        mysql> FLUSH PRIVILEGES;
        ```

    === "Users MGMT"
        Show User & ACLs
        ```
        mysql> SELECT * FROM mysql.user
        ```

        Create User
        Where % is any IP and localhost is only from 127.0.0.1
        ```
        mysql> CREATE USER 'cosckoya'@'%' IDENTIFIED BY 'пароль';
        ```

        Delete Users
        ```
        mysql> DROP USER 'cosckoya'@'%';
        ```


## PostgreSQL

!!! info
    - [PostgrSQL Tutorials & Resources](https://www.postgresql.org/docs/online-resources/)

???- info "Commands"
    === "Basic"
        · Help
        ```
        postgre> \?
        ```

        · List databases
        ```
        postgre> \l
        ```

        · Connect database
        ```
        postgre> \l
        ```

    === "Connect"
        ```
        psql --host=<HOST> --port=5432 --username=<USER> --dbname=<DBNAME>
        ```

    === "Dump"
        ```
        pg_dump --host=<HOST> --port=5432 --username=<USER> --dbname=<DBNAME> | gzip > <FILE>
        ```

    === "Import"
        ```bash
        psql --host=<HOST> --port=5432 --username=<USER> --dbname=<DBNAME> < <FILE>
        ```

???- notes "MGMT Queries"
    === "Create DB & User"
        ```
        postgre> CREATE DATABASE cosckoyadb;
        postgre> CREATE USER cosckoya WITH ENCRYPTED PASSWORD 'пароль';
        postgre> GRANT ALL PRIVILEGES ON DATABASE cosckoyadb TO cosckoya;
        --- Alternative
        postgre> GRANT CONNECT ON DATABASE cosckoyadb TO cosckoya;
        postgre> GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA cosckoyadb TO cosckoya;
        ```

    === "Drop Database"
        ```
        postgre> DROP DATABASE cosckoya;
        ```
