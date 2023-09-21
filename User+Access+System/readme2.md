[moonwalker@web-server ~]$ sudo dnf install httpd
Last metadata expiration check: 0:01:37 ago on mar 28 feb 2023 16:03:47 EST.
Dependencies resolved.
======================================================================================================================
 Package                    Arch                  Version                                Repository              Size
======================================================================================================================
Installing:
 httpd                      x86_64                2.4.6-98.el7.centos.6                  updates                2.7 M
Installing dependencies:
 apr                        x86_64                1.4.8-7.el7                            base                   104 k
 apr-util                   x86_64                1.5.2-6.el7                            base                    92 k
 mailcap                    noarch                2.1.41-2.el7                           base                    31 k
 httpd-tools                x86_64                2.4.6-98.el7.centos.6                  updates                 94 k

Transaction Summary
======================================================================================================================
Install  5 Packages

Total download size: 3.0 M
Installed size: 10 M
Is this ok [y/N]: y
Downloading Packages:
(1/5): mailcap-2.1.41-2.el7.noarch.rpm                                                2.0 kB/s |  31 kB     00:15    
(2/5): apr-1.4.8-7.el7.x86_64.rpm                                                     6.5 kB/s | 104 kB     00:15    
(3/5): apr-util-1.5.2-6.el7.x86_64.rpm                                                5.8 kB/s |  92 kB     00:15    
(4/5): httpd-tools-2.4.6-98.el7.centos.6.x86_64.rpm                                   124 kB/s |  94 kB     00:00    
(5/5): httpd-2.4.6-98.el7.centos.6.x86_64.rpm                                         211 kB/s | 2.7 MB     00:13    
----------------------------------------------------------------------------------------------------------------------
Total                                                                                  40 kB/s | 3.0 MB     01:16     
Running transaction check
Transaction check succeeded.
Running transaction test
Transaction test succeeded.
Running transaction
  Preparing        :                                                                                              1/1 
  Installing       : apr-1.4.8-7.el7.x86_64                                                                       1/5 
  Running scriptlet: apr-1.4.8-7.el7.x86_64                                                                       1/5 
  Installing       : apr-util-1.5.2-6.el7.x86_64                                                                  2/5 
  Running scriptlet: apr-util-1.5.2-6.el7.x86_64                                                                  2/5 
  Installing       : httpd-tools-2.4.6-98.el7.centos.6.x86_64                                                     3/5 
  Installing       : mailcap-2.1.41-2.el7.noarch                                                                  4/5 
  Running scriptlet: httpd-2.4.6-98.el7.centos.6.x86_64                                                           5/5 
  Installing       : httpd-2.4.6-98.el7.centos.6.x86_64                                                           5/5 
  Running scriptlet: httpd-2.4.6-98.el7.centos.6.x86_64                                                           5/5 
  Verifying        : apr-1.4.8-7.el7.x86_64                                                                       1/5 
  Verifying        : apr-util-1.5.2-6.el7.x86_64                                                                  2/5 
  Verifying        : mailcap-2.1.41-2.el7.noarch                                                                  3/5 
  Verifying        : httpd-2.4.6-98.el7.centos.6.x86_64                                                           4/5 
  Verifying        : httpd-tools-2.4.6-98.el7.centos.6.x86_64                                                     5/5 

Installed:
  httpd-2.4.6-98.el7.centos.6.x86_64     apr-1.4.8-7.el7.x86_64                       apr-util-1.5.2-6.el7.x86_64    
  mailcap-2.1.41-2.el7.noarch            httpd-tools-2.4.6-98.el7.centos.6.x86_64    

Complete!
[moonwalker@web-server ~]$ systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:httpd(8)
           man:apachectl(8)
[moonwalker@web-server ~]$ systemctl enable httpd
==== AUTHENTICATING FOR org.freedesktop.systemd1.manage-unit-files ===
Authentication is required to manage system service or unit files.
Authenticating as: moonwalker
Password: 
==== AUTHENTICATION COMPLETE ===
Created symlink from /etc/systemd/system/multi-user.target.wants/httpd.service to /usr/lib/systemd/system/httpd.service.
==== AUTHENTICATING FOR org.freedesktop.systemd1.reload-daemon ===
Authentication is required to reload the systemd state.
Authenticating as: moonwalker
Password: 
==== AUTHENTICATION COMPLETE ===
[moonwalker@web-server ~]$ systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:httpd(8)
           man:apachectl(8)
[moonwalker@web-server ~]$ sudo systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:httpd(8)
           man:apachectl(8)
[moonwalker@web-server ~]$ sudo systemctl start httpd
[moonwalker@web-server ~]$ sudo systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)
   Active: active (running) since mar 2023-02-28 16:07:57 EST; 2s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 4002 (httpd)
   Status: "Processing requests..."
   CGroup: /system.slice/httpd.service
           ├─4002 /usr/sbin/httpd -DFOREGROUND
           ├─4003 /usr/sbin/httpd -DFOREGROUND
           ├─4004 /usr/sbin/httpd -DFOREGROUND
           ├─4005 /usr/sbin/httpd -DFOREGROUND
           ├─4006 /usr/sbin/httpd -DFOREGROUND
           └─4007 /usr/sbin/httpd -DFOREGROUND

feb 28 16:07:56 web-server systemd[1]: Starting The Apache HTTP Server...
feb 28 16:07:57 web-server httpd[4002]: AH00558: httpd: Could not reliably determine the server's fully qualif...ssage
feb 28 16:07:57 web-server systemd[1]: Started The Apache HTTP Server.
Hint: Some lines were ellipsized, use -l to show in full.
[moonwalker@web-server ~]$ 
[moonwalker@web-server ~]$ 
[moonwalker@web-server ~]$ 
[moonwalker@web-server ~]$ sudo firewall-cmd --permanent --zone=public --add-service=http
[sudo] password for moonwalker: 
success
[moonwalker@web-server ~]$ sudo firewall-cmd --permanent --zone=public --add-service=https
success
[moonwalker@web-server ~]$ sudo firewall-cmd --reload
success
[moonwalker@web-server ~]$ ls /var/log/httpd/
ls: cannot open directory /var/log/httpd/: Permission denied
[moonwalker@web-server ~]$ sudo ls /var/log/httpd/
access_log  error_log
[moonwalker@web-server ~]$ sudo tail /var/log/httpd/access_log
192.168.43.23 - - [28/Feb/2023:16:28:18 -0500] "GET /noindex/css/bootstrap.min.css HTTP/1.1" 200 19341 "http://192.168.43.42/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
192.168.43.23 - - [28/Feb/2023:16:28:18 -0500] "GET /noindex/css/open-sans.css HTTP/1.1" 200 5081 "http://192.168.43.42/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
192.168.43.23 - - [28/Feb/2023:16:28:18 -0500] "GET /images/poweredby.png HTTP/1.1" 200 3956 "http://192.168.43.42/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
192.168.43.23 - - [28/Feb/2023:16:28:18 -0500] "GET /images/apache_pb.gif HTTP/1.1" 200 2326 "http://192.168.43.42/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
192.168.43.23 - - [28/Feb/2023:16:28:18 -0500] "GET /noindex/css/fonts/Bold/OpenSans-Bold.woff HTTP/1.1" 404 239 "http://192.168.43.42/noindex/css/open-sans.css" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
192.168.43.23 - - [28/Feb/2023:16:28:18 -0500] "GET /noindex/css/fonts/Light/OpenSans-Light.woff HTTP/1.1" 404 241 "http://192.168.43.42/noindex/css/open-sans.css" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
192.168.43.23 - - [28/Feb/2023:16:28:18 -0500] "GET /noindex/css/fonts/Bold/OpenSans-Bold.ttf HTTP/1.1" 404 238 "http://192.168.43.42/noindex/css/open-sans.css" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
192.168.43.23 - - [28/Feb/2023:16:28:18 -0500] "GET /noindex/css/fonts/Light/OpenSans-Light.ttf HTTP/1.1" 404 240 "http://192.168.43.42/noindex/css/open-sans.css" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
192.168.43.23 - - [28/Feb/2023:16:28:18 -0500] "GET /favicon.ico HTTP/1.1" 404 209 "http://192.168.43.42/" "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36"
192.168.43.23 - - [28/Feb/2023:16:29:11 -0500] "-" 408 - "-" "-"
[moonwalker@web-server ~]$ journalctl -u httpd
-- Logs begin at mar 2023-02-28 09:43:58 EST, end at mar 2023-02-28 16:32:12 EST. --
feb 28 16:07:56 web-server systemd[1]: Starting The Apache HTTP Server...
feb 28 16:07:57 web-server httpd[4002]: AH00558: httpd: Could not reliably determine the server's fully qualified doma
feb 28 16:07:57 web-server systemd[1]: Started The Apache HTTP Server.
[moonwalker@web-server ~]$ 

