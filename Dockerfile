FROM php:8.1-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev zlib1g-dev libzip-dev unzip git curl libcurl4-openssl-dev

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd zip pdo pdo_mysql

WORKDIR /var/www
COPY . .

# Run Composer install
RUN composer install --no-dev --optimize-autoloader --prefer-dist

CMD ["php-fpm"]
