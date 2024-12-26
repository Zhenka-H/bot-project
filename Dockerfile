FROM php:8.1-fpm

RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev zlib1g-dev libzip-dev unzip git curl libcurl4-openssl-dev

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Verify PHP and Composer installations
RUN php -v
RUN composer -v

RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd zip pdo pdo_mysql

WORKDIR /var/www
COPY . .

RUN composer install --no-dev --optimize-autoloader --prefer-dist -vvv

CMD ["php-fpm"]
