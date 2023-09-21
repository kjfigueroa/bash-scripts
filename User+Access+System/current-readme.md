<a name="readme-top"></a>
# User Access System

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Contents</summary>
  <ol>
    <li>
      <a href="#description">Description</a>
    </li>
    <li>
      <a href="#basic-infrastructure">Basic Infrastructure</a>
      <ul>
        <li><a href="#additional-steps">Additional Steps</a></li>
      </ul>
    </li>
    <li>
       <a href="#spin-up-of-mysql-server">Spin up of MySQL Server</a>
       <ul>
          <li><a href="#installation">Installation</a></li>
          <li><a href="#post-installation">Post-Installation</a></li>
       </ul>
    </li>
  </ol>
</details>

## Description

It's a simple project which idea is to provide user access to an web app through user identification by **user** and **passwd**. 

in a simple way, is for show a method to achieve this task using : **HTML**, **CSS**, **PHP**, and **MySQL**.

## Basic Infrastructure

Just need to spin up two simple VM (https://www.centos.org/centos-linux/) in VirtualBox, such as:

```sh
   Static hostname: web-server
         Icon name: computer-vm
           Chassis: vm
    Virtualization: kvm
  Operating System: CentOS Linux 7 (Core)
       CPE OS Name: cpe:/o:centos:centos:7
            Kernel: Linux 3.10.0-1160.71.1.el7.x86_64
      Architecture: x86-64
```
<p align="right">[<a href="#readme-top">back to top</a>]</p>

#### Additional steps: 
On the *WebServer* we can set up the hostname and create a new one called i.e **moonwalker**
```shell
[root@localhost ~]# hostnamectl set-hostname web-server
[root@web-server ~]# adduser moonwalker
[root@web-server ~]# passwd moonwalker
[root@web-server ~]# usermod -aG wheel moonwalker
```
Likewise for the DB-Server
```shell
[root@localhost ~]# hostnamectl set-hostname db-server
[root@db-server ~]# adduser moonwalker
[root@db-server ~]# passwd moonwalker
[root@db-server ~]# usermod -aG wheel moonwalker
```
in this way you can work comfortably avoiding confusion between the both.

<p align="right">[<a href="#readme-top">back to top</a>]</p>

## Spin up of MySQL Server

You can follow all the instructions indicated in the documented source of the **MySQL** software ([here](https://dev.mysql.com/doc/refman/8.0/en/linux-installation.html)).<br>
So in a less complicated way "*just because this demo doesn't really require a high implementation effort*" I'll use as an alternative, the package manager on its system to automatically download and install **MySQL** with packages from the native software repositories of its Linux distribution (which is YUM). These native packages are often several versions behind the currently available release.

#### Installation
Is possible simply by following the steps from the source to download and configure the repository (that mean using the native software repositories of your Linux distribution), or just follow the installation suggested by the repository manager after the update, in my case, I just followed the following commands:

```shell
[moonwalker@db-server ~]$ sudo dnf search mysql |grep -i 'database server'
```
```
Last metadata expiration check: 0:07:28 ago on lun 27 feb 2023 12:07:14 EST.
mysql-community-test.x86_64 : Test suite for the MySQL database server
mysql-community-server.x86_64 : A very fast and reliable SQL database server
```
```shell
[moonwalker@db-server ~]$ sudo dnf install mysql-community-server
```
Finally we get: 
```
[moonwalker@db-server ~]$ which mysql
/usr/bin/mysql
[moonwalker@db-server ~]$ mysql --version
mysql  Ver 8.0.32 for Linux on x86_64 (MySQL Community Server - GPL)
```
<p align="right">[<a href="#readme-top">back to top</a>]</p>

#### Post-Installation

Luego de la instalación, se puede apreciar en los logs del sistema `/var/log/mysqld.log` lo siguiente:

Normalmente el sistema se instala por defecto con la creación del usuario `root` en la DB.
El cual, cuenta con un `password` temporal que se puede ubicar mediante la busqueda:

```bash
[moonwalker@db-server ~]$ sudo grep -Ri "password" /var/log/mysqld.log |awk '{print $NF}' 
```

Algo a tener en cuenta son los parámetros de utilidad (por defecto a la instalación) para establecer una conexión remota con el servidor (puede encontrar un detalle en [mysql-windows-and-ssh](https://dev.mysql.com/doc/refman/8.0/en/windows-and-ssh.html) | [audit-log-file-formats](https://dev.mysql.com/doc/refman/8.0/en/audit-log-file-formats.html))

Luego de conocer el `password` del usuario `root`, podemos acceder al servidor de **MySQL** de forma local, pero primero, para ello debemos habilitar e iniciar el servicio de `mysqld`, para el caso de este sencillo proyecto es posible usar el `systemctl` del sistema. 

Ahora si, podemos lanzar el comando para validar el acceso: 
```bash
sudo mysql -u root -p
```

Pueden observarse detalles para las bases de datos iniciales:
```
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
+--------------------+
4 rows in set (0,00 sec)
```

Y los detalles para los usuarios iniciales:

```
mysql> select user from user;
+------------------+
| user             |
+------------------+
| mysql.infoschema |
| mysql.session    |
| mysql.sys        |
| root             |
+------------------+
5 rows in set (0,00 sec)

mysql> select host,plugin from user where User='root';
+-----------+-----------------------+
| host      | plugin                |
+-----------+-----------------------+
| localhost | caching_sha2_password |
+-----------+-----------------------+
1 row in set (0,00 sec)


```
Para garantizar el acceso remoto al servidor es necesario lo siguiente:

1. agregar unas lineas al archivo de configuración 

```bash
moonwalker@db-server ~]$ echo -e "[client]\nsocket=/var/lib/mysql/mysql.sock" >> /etc/my.cfn
moonwalker@db-server ~]$ sudo systemctl restart mysqld
```

2. Habilitar la configuración del firewall
```bash
[moonwalker@db-server ~]$ sudo firewall-cmd --add-port=3306/tcp --permanent
success
[moonwalker@db-server ~]$ sudo firewall-cmd --reload
success
```

3. Crear un nuevo usuario para el acceso remoto (para este ejemplo, lo llamaré `webserver`):
```
mysql> CREATE USER 'webserver1'@'<IP>' IDENTIFIED BY '<passwd>';
mysql> select user from user;
+------------------+
| user             |
+------------------+
| webserver1       |
| mysql.infoschema |
| mysql.session    |
| mysql.sys        |
| root             |
+------------------+
5 rows in set (0,00 sec)

```

Pero aun se deben revalidar los privilegios para el nuevo usuario (toda la información necesaria para comprender el contexto puede hallarse en el enlace https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html) 

```
mysql> GRANT ALL PRIVILEGES ON *.* TO 'webserver1'@'192.168.43.23' WITH GRANT OPTION;
Query OK, 0 rows affected (0,06 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0,04 sec)

```
Finalmente puede validarse el acceso desde una maquina remota:

```
kevin:[~]$ cat /etc/os-release |head -n1
PRETTY_NAME="Ubuntu 22.04.1 LTS"
kevin:[~]$ sudo mysql -u webserver1 -p -h <IP-db-server>
[sudo] password for kevin: 
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 8.0.32 MySQL Community Server - GPL

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> 
```
