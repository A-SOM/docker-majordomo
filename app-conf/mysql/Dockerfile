FROM mysql:5.7

RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Etc/UTC /etc/localtime
RUN "date"

COPY config.cnf /etc/mysql/conf.d
