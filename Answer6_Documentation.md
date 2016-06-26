
# ANSWER 6

## HOW-TO INSTALL AND CONFIGURE APACHE SERVER ON FEDORA LINUX

**INSTALLATON OF APACHE SERVER:**

1 Update available packages: 
```
dnf update
```
2 Install Apache server:
```
dnf install httpd
```
3 Enable automatic start of Apache server:
```
systemctl enable httpd.service
```
4 Start server now:
```
systemctl start httpd.service
```
5 Install SSL support for Apache server:
```
dnf install mod_ssl
```

**CONFIGURATION:**

1 Setting permanent redirect from HTTP to HTTPS
```
Add the following text to file */etc/httpd/conf/http.conf*

<VirtualHost *:80>
   ServerName demo.swizzle.ch:80
   Redirect permanent / https://demo.swizzle.ch/
</VirtualHost>
```
2 