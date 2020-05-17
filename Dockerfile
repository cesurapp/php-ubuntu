FROM phusion/baseimage:latest
RUN apt-get update -y

#-------------------
# Nginx
#-------------------
RUN apt-get install -y nginx
RUN mkdir /etc/service/nginx
ADD ./nginx /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run

#-------------------
# PHP
#-------------------
RUN add-apt-repository -y ppa:ondrej/php && apt-get update
RUN apt-get install -y php7.4
RUN apt-get install -y php7.4-cli \
        php7.4-fpm \
        php7.4-gd \
        php7.4-common \
        php7.4-intl \
        php7.4-json \
        php7.4-mbstring \
        php7.4-curl \
        php7.4-opcache \
        php7.4-pdo \
        php7.4-redis \
        php7.4-memcached \
        php7.4-mysql \
        php7.4-tidy \
        php7.4-xml \
        php7.4-zip \
        php7.4-bcmath
RUN mkdir /var/run/php && touch /var/run/php/php7.4-fpm.sock

ADD ./php /etc/php/7.4/cli/conf.d
ADD ./php /etc/php/7.4/fpm/conf.d
ADD ./fpm /etc/php/7.4/fpm/pool.d
RUN mkdir /etc/service/php-fpm
ADD ./php-fpm /etc/service/php-fpm/run
RUN chmod +x /etc/service/php-fpm/run

#-------------------
# Startup Command
#-------------------
RUN mkdir -p /etc/my_init.d
ADD ./entrypoint.sh /etc/my_init.d/entrypoint.sh
RUN chmod +x /etc/my_init.d/entrypoint.sh

#-------------------
# Clear
#-------------------
CMD ["/sbin/my_init"]
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
WORKDIR /var/www/
