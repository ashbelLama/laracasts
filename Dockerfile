FROM php:8.3-fpm

# Update the www-data user and group IDs to 1000
RUN usermod -u 1000 www-data && \
    groupmod -g 1000 www-data

WORKDIR /var/www/html

# Install necessary packages including zip and unzip
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev

# Install PHP extensions
RUN docker-php-ext-install zip

# Copy the project files and ensure proper ownership
COPY --chown=www-data:www-data . .

# Copy composer from the Composer image
COPY --from=composer:lts /usr/bin/composer /usr/bin/composer

# Ensure proper directory structure for logs
RUN mkdir -p /var/www/html/storage/logs && \
    touch /var/www/html/storage/logs/laravel.log

# Fix ownership and permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache && \
    chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Use entrypoint script to handle initialization
# ENTRYPOINT [ "./.entrypoint.sh" ]

# Ensure the container runs php-fpm after initialization
CMD [ "php-fpm" ]

# FROM php:8.3-fpm

# # Arguments defined in docker-compose.yml file
# ARG user
# ARG uid

# # # Install system dependencies
# # RUN apt-get update && apt-get install -y \
# #     git \
# #     unzip \
# #     libzip-dev

# # # Install PHP extensions
# # RUN docker-php-ext-install zip

# # Copy composer from the Composer image
# COPY --from=composer:lts /usr/bin/composer /usr/bin/composer

# # Create system user to run Composer and Artisan commands
# RUN useradd -G www-data,root -u ${uid} -d /home/${user} ${user}
# RUN mkdir -p /home/${user}/.composer && \
#     chown -R ${user}:${user} /home/${user}

# # Set working directory
# WORKDIR /var/www/html

# # Set the user
# USER ${user}

# # # Copy files
# # COPY . .
