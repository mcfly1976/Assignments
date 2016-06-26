
# ANSWER 6

## HOW-TO INSTALL AND CONFIGURE APACHE SERVER ON FEDORA LINUX

**INSTALLATON OF APACHE SERVER:**

* Update available packages: 
```
dnf update
```
* Install Apache server:
```
dnf install httpd
```
* Enable automatic start of Apache server:
```
systemctl enable httpd.service
```
* Start server now:
```
systemctl start httpd.service
```
* Install SSL support for Apache server:
```
dnf install mod_ssl
```

**CONFIGURATION:**



