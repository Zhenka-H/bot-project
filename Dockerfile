FROM php:8.1-fpm

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zlib1g-dev libzip-dev unzip git
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd zip pdo pdo_mysql

WORKDIR /var/www
COPY . .

RUN composer install --no-dev --optimize-autoloader

CMD ["php-fpm"]
