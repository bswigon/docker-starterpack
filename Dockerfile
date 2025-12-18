# Użyj najnowszego obrazu PHP z FPM dla optymalizacji pod Docker
FROM php:8.3-fpm-alpine

# Lista wszystkich pakietów kompilacyjnych (temporary build dependencies)
# Dodano "make"
ARG DEV_PACKAGES="autoconf gcc g++ musl-dev make"

# Lista wymaganych bibliotek runtime (dependency libraries)
ARG RUN_PACKAGES="git libzip-dev zlib-dev rabbitmq-c-dev"

# 1. Instalacja zależności systemowych i kompilacja rozszerzeń
RUN apk update && apk add --no-cache ${DEV_PACKAGES} ${RUN_PACKAGES} \
    # Instalacja podstawowych rozszerzeń PHP
    && docker-php-ext-install pdo_mysql zip \
    # Instalacja i włączenie Redis (wymaga kompilatora, make)
    && pecl install redis \
    && docker-php-ext-enable redis \
    # Instalacja i włączenie AMQP (dla RabbitMQ)
    && pecl install amqp \
    && docker-php-ext-enable amqp \
    # Czyszczenie: Usuń pakiety deweloperskie i czyść cache APK
    && apk del ${DEV_PACKAGES} \
    && rm -rf /var/cache/apk/*

# Ustaw folder roboczy na katalog aplikacji Symfony
WORKDIR /var/www/html

# Pobierz i zainstaluj Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Dodaj uprawnienia dla użytkownika www-data, aby Composer i Symfony działały
RUN chown -R www-data:www-data /var/www/html
USER www-data