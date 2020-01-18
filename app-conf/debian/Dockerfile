FROM debian:buster-slim
RUN apt-get update
RUN apt-get install nginx git iputils-ping -y
RUN apt-get install php php-cgi php-cli php-pear php-mysql php-mbstring php-xml php-fpm curl libcurl4 libcurl4-openssl-dev php-curl php-gd -y
RUN        apt-get -y install supervisor && \
           mkdir -p /var/log/supervisor && \
           mkdir -p /etc/supervisor/conf.d
RUN        mkdir /var/log/supervisord
COPY supervisor/supervisor.conf /etc/supervisor.conf
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/sites-enabled/default

COPY php-fpm/php.ini /usr/local/etc/php/
COPY php-fpm/php-fpm.conf /usr/local/etc/php-fpm.d/php-fpm.conf

WORKDIR /var/www/html
CMD /usr/bin/supervisord -n -c /etc/supervisor.conf
RUN apt-get install ffmpeg smartmontools net-tools -y