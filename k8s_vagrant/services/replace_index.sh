# the variable $varservicename is the environment variable when run the container
# for example: docker run --name helllotext -d -e varservicename=hellotext nginxdemo
# print text to /usr/share/nginx/html/index.html
mkdir /usr/share/nginx/html/$varservicename
cp /usr/share/nginx/html/index.html /usr/share/nginx/html/$varservicename/
# this script print the container's hostname in the index.html
sed -i s,varhostname,`hostname`,g /usr/share/nginx/html/$varservicename/index.html
sed -i s,varservicename,"$varservicename",g /usr/share/nginx/html/$varservicename/index.html

# remove all contents of homepage for easier to regconize mainsite and service site.
sed -i s,varhostname,`hostname`,g /usr/share/nginx/html/index.html
sed -i s,varservicename," rootdir of $varservicename",g /usr/share/nginx/html/index.html