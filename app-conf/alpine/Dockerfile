FROM alpine
RUN apt-get update && apt-get upgrade
RUN apt-get install apache2 apache2-utils -y
RUN apt-get install php php-cgi php-cli php-pear php-mysql php-mbstring php-xml -y
RUN apt-get install curl libcurl3 libcurl3-dev php-curl -y
RUN apt-get install libapache2-mod-php -y
RUN echo short_open_tag = On >> /etc/php/7.0/apache2/php.ini
RUN a2enmod rewrite
RUN        apt-get -y install supervisor && \
           mkdir -p /var/log/supervisor && \
           mkdir -p /etc/supervisor/conf.d
RUN        mkdir /var/log/supervisord
ADD supervisor/supervisor.conf /etc/supervisor.conf
CMD /usr/bin/supervisord -n -c /etc/supervisor.conf
