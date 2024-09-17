#!/bin/bash

echo "==============================================="
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R 755 /var/www/html/storage /var/www/html/bootstrap/cache
cp .env.example .env
composer install

php artisan key:generate

php-fpm