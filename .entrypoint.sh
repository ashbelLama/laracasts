#!/bin/bash

echo "==============================================="
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R 755 /var/www/html/storage /var/www/html/bootstrap/cache

if [ ! -f .env ]; then
  cp .env.example .env
fi

composer install

php artisan key:generate
php artisan migrate

php-fpm
