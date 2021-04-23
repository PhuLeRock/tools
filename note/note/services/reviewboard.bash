# https://bianchirick.wordpress.com/2014/07/09/installing-reviewboard-2-0-x-on-ubuntu-12-04-x/
apt-get update
aptitude install libapache2-mod-wsgi libcache-memcached-perl memcached patch python-dev python-ldap python-setuptools subversion python-svn python-subvertpy
apt-get install build-essential
apt-get build-dep python-imaging libjpeg8 libjpeg62-dev libfreetype6 libfreetype6-dev
easy_install ReviewBoard

easy_install nose Sphinx

export DEBIAN_FRONTEND=noninteractive
apt-get install -y -q mysql-server
service mysql start
mysqladmin -u root password mysecretpasswordgoeshere

apt-get install libmysqlclient-dev 
easy_install mysql-python
-create db aasdad


apt-get install apache2 libapache2-mod-wsgi memcached
rb-site install /var/www/reviewboard

/etc/apache2/sites-available/reviewboard-apache-wsgi.conf

<VirtualHost *:80>
ServerName reviewboard.harveynash.vn
DocumentRoot "/var/www/reviewboard/htdocs"
# Error handlers
ErrorDocument 500 /errordocs/500.html
WSGIPassAuthorization On
WSGIScriptAlias "/" "/var/www/reviewboard/htdocs/reviewboard.wsgi/"
<Directory "/var/www/reviewboard/htdocs">
AllowOverride All
Options -Indexes +FollowSymLinks
Allow from all
</Directory>
# Prevent the server from processing or allowing the rendering of
# certain file types.
<Location "/var/www/reviewboard/htdocs/media/uploaded">
SetHandler None
Options None
AddType text/plain .html .htm .shtml .php .php3 .php4 .php5 .phps .asp
AddType text/plain .pl .py .fcgi .cgi .phtml .phtm .pht .jsp .sh .rb
<IfModule mod_php5.c>
php_flag engine off
</IfModule>
</Location>
# Alias static media requests to filesystem
Alias /media "/var/www/reviewboard/htdocs/media"
Alias /static "/var/www/reviewboard/htdocs/static"
Alias /errordocs "/var/www/reviewboard/htdocs/errordocs"
Alias /favicon.ico "/var/www/reviewboard/htdocs/static/rb/images/favicon.png"
</VirtualHost>

ln -s /etc/apache2/sites-available/reviewboard-apache-wsgi.conf /etc/apache2/sites-enabled/reviewboard-apache-wsgi.conf
ln -s /etc/apache2/mods-available/wsgi.load /etc/apache2/mods-enabled/wsgi.load


chown -R www-data.www-data /var/www/reviewboard/htdocs/media/uploaded
chown -R www-data.www-data /var/www/reviewboard/data
chown -R www-data.www-data /var/www/reviewboard/htdocs/media/ext
chown -R www-data.www-data /var/www/reviewboard/htdocs/static/ext
chown -R www-data.www-data /var/www/reviewboard/htdocs/media/uploaded
chmod -R 744 /var/www/reviewboard/htdocs/media/uploaded

apt-get install subversion python-svn cvs git-core  
easy_install django-storages # amazon s3
  
  
  
  
  
  