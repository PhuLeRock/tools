#!/bin/sh
####
# This script compiles HTTPD - PHP automatically
# Author TuNH
####

resource_path="/source/apache-php/"

CheckPrefix() 
{
	# httpd prefix
	if [ ! -d /ssg/httpd227 ]
	then
		mkdir /ssg/httpd227/
	fi
	# php-apache prefix
	if [ ! -d /ssg/php-apache ]
	then
		mkdir /ssg/php-apache/
	fi
	# init scripts folder
	if [ ! -d /ssg/init.d ]
	then
		mkdir /ssg/init.d/
	fi
	
	echo "Prefix folders have been checked and created (if not exist)"
}

UntarResource()
{
	cd $resource_path
	tar -zxf httpd-2.2.27.tar.gz
	tar -zxf php-5.4.17.tar.gz
	tar -zxvf memcache-3.0.6.tgz

	echo "Untarred all resources."
}

CompileHttpd()
{
	cd $resource_path
	cd httpd-2.2.27

	./configure --prefix=/ssg/httpd227 --enable-layout=RedHat --enable-so --enable-cgi --enable-info --enable-rewrite --enable-speling --enable-usertrack --enable-deflate --enable-mime-magic --enable-vhost-alias --enable-proxy --enable-ssl --with-ssl=/ssg/openssl/bin --enable-mime-magic --with-mpm=prefork --enable-modules=access --enable-modules=auth --enable-modules=log_config --with-included-apr --enable-mods-shared="isapi file_cache cache disk_cache mem_cache ext_filter expires headers usertrack unique_id status info cgi cgid speling ssl"
	sleep 2

	make && make install && \

	echo "----- ----- ----- COMPILE HTTPD OK"
}

CompilePHPApache()
{
	cd $resource_path
	cd php-5.4.17

	./configure --prefix=/ssg/php-apache --with-apxs2=/ssg/httpd227/sbin/apxs --with-config-file-path=/ssg/php-apache/etc/php.ini --with-libdir=lib64 --disable-fpm --with-mysql --enable-sockets --with-mysqli --with-jpeg-dir=/usr --with-freetype-dir=/usr --with-png-dir=/usr --with-gd --enable-gd-native-ttf --with-gdbm --with-gettext --enable-mbstring --with-pcre-regex --with-regex --enable-soap  --enable-pdo --enable-zip --with-zlib --with-bz2 --with-curl --enable-ftp --enable-magic-quotes --with-iconv --enable-pcntl --with-kerberos --with-pdo-mysql --with-mcrypt --with-mhash --with-gmp --enable-libxml --with-snmp --with-openssl --with-openssl-dir=/ssg/openssl/

	sleep 2

	make && make install && \

	echo "----- ----- ----- COMPILE PHP for HTTPD OK"
}

CompilePHPExtension()
{
	cd $resource_path
	cd php-5.4.17/ext/openssl
	cp config0.m4 config.m4
	chmod 755 config.m4
	/ssg/php-apache/bin/phpize
	./configure --with-php-config=/ssg/php-apache/bin/php-config --with-openssl=/ssg/openssl
	make && make install
	
	echo "OpenSSL extension for PHP has been compiled successfully!"
	
	sleep 2
	
	cd $resource_path
	cd memcache-3.0.6
	chmod 755 configure
	/ssg/php-apache/bin/phpize
	./configure --with-php-config=/ssg/php-apache/bin/php-config
	make && make install

	echo "Memcached extension for PHP has been compiled successfully!"
}

PrepareFiles()
{
	cd $resource_path
	cp prepare_files/httpd /ssg/init.d/
	cp prepare_files/php-apache /ssg/init.d/
	chmod 755 /ssg/init.d/httpd
	chmod 755 /ssg/init.d/php-apache

	cp prepare_files/php.ini /ssg/php-apache/etc/
	
	echo "Copied init files and conf files successfully!"
}

## RUN

CheckPrefix
sleep 5
UntarResource
sleep 5
CompileHttpd
sleep 5
CompilePHPApache
sleep 5
CompilePHPExtension
sleep 5
PrepareFiles
sleep 5 

echo "ALL DONE! Please check again!"




