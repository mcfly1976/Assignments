
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
Add the following text to file /etc/httpd/conf/http.conf

<VirtualHost *:80>
   ServerName demo.swizzle.ch:80
   Redirect permanent / https://demo.swizzle.ch/
</VirtualHost>
```
2 Create CSR to use with www.startssl.com
```
Follow instructions from www.startssl.com to verify domain name and create CSR with following command:

openssl req -newkey rsa:2048 -keyout demo.swizzle.key -out demo.swizzle.csr
```
3 Use text from .csr file to create and download certificate according to instructions from startssl.com
4 Copy certificate files to correct folder
```
mkdir /etc/httpd/ssl/
cp pathtofile/demo.swizzle.ch.crt /etc/httpd/ssl/
cp pathtofile/demo.swizzle.ch.key /etc/httpd/ssl/
cp pathtofile/1_root_bundle.crt etc/httpd/ssl/
```
5 Configure ssl.conf to use the correct certificates
```
Add or change the following text to file /etc/httpd/conf.d/ssl.conf:

<VirtualHost _default_:443>

DocumentRoot "/var/www/html"
ServerName demo.swizzle.ch

ErrorLog logs/ssl_error_log
TransferLog logs/ssl_access_log
LogLevel warn

SSLEngine on

SSLCertificateFile /etc/httpd/ssl/demo.swizzle.ch.crt
SSLCertificateKeyFile /etc/httpd/ssl/demo.swizzle.ch.key
SSLCACertificateFile /etc/httpd/ssl/1_root_bundle.crt

</VirtualHost> 

Other settings can be left at default value.
```
6 Create index.html file and put it in root folder for html files
```
cp pahttofile/index.html /var/www/html/index.html
```
7 Check if Apache configuration has no errors
If there are errors, fix them first.
```
apachectl configtest
```
8 Restart Apache httpd service
```
service httpd restart
```
9 Test if webpage and HTTPS redirect is working
