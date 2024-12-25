# Set the working directory
WORKDIR /var/www/html

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y libpng-dev libjpeg62-turbo-dev libfreetype6-dev zip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo_mysql

# Install Composer globally
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy the Laravel app code into the container
COPY . /var/www/html

# Install Composer dependencies
RUN composer install --ignore-platform-reqs --no-dev --optimize-autoloader

# Set the appropriate file permissions
RUN chown -R www-data:www-data /var/www/html

# Expose the port for the app
EXPOSE 8000

# Run the Laravel app
CMD php artisan serve --host=0.0.0.0 --port=8000
