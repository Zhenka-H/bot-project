# Use the official PHP image with FPM
FROM php:8.1-fpm

# Set working directory inside the container
WORKDIR /var/www/html

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    zip \
    unzip \
    libzip-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql gd zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the project files into the container
COPY . .

# Run Composer install, ignoring platform requirements
RUN composer install --ignore-platform-reqs --no-dev --optimize-autoloader

# Install Node.js dependencies (for assets)
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash \
    && apt-get install -y nodejs \
    && npm install

# Expose port 8000 for Laravel app
EXPOSE 8000

# Command to run the Laravel application
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
