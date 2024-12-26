# Ensure all dependencies are installed before running composer
RUN apt-get update && apt-get install -y \
    libpng-dev libjpeg-dev libfreetype6-dev zlib1g-dev libzip-dev unzip git curl libcurl4-openssl-dev libxml2-dev

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Additional troubleshooting step: Clean up cache and install
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /var/www
COPY . .

RUN composer install --no-dev --optimize-autoloader --prefer-dist

CMD ["php-fpm"]
