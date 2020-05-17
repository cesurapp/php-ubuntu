# PHP Ubuntu

PHP Version: 7.4 - appaydin/php-ubuntu

The default directory /var/www is set to port 80.

Installed Applications: Nginx - PHP7.4 - Crontab - Runit - SSH

For detailed documentation, [See](https://github.com/phusion/baseimage-docker) here.


### Example Application:
docker-compose:
```yaml
version: '3'

services:
    php:
        build: .
        #volumes:
            #- ./cron.d:/etc/cron.d
            #- ./service.d:/etc/service.d
            #- ./nginx.conf:/etc/nginx/nginx.conf
            #- ./php.ini:/etc/php/7.4/fpm/conf.d/php.ini
            #- ./php-fpm.conf:/etc/php/7.4/fpm/pool.d/www-data
```

### Example Service:
/service.d/nginx:
```shell
#!/bin/sh
exec nginx >> /var/log/nginx.log 2>&1
```