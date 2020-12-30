FROM nginx:1.14.0-alpine
ENV varservicename Mainsite

# all build material, just for storing the material
RUN mkdir /src
COPY Dockerfile nginx.default.conf replace_index.sh index.html /src/
#
#RUN mkdir /cert
#COPY ca.crt ca.key /cert/
RUN rm /etc/nginx/conf.d/default.conf
RUN rm /usr/share/nginx/html/index.html
COPY nginx.default.conf /etc/nginx/conf.d/default.conf
COPY index.html /usr/share/nginx/html/index.html
COPY replace_index.sh /


# replace index.html and run 
CMD  /bin/sh /replace_index.sh && /usr/sbin/nginx -g "daemon off;"
