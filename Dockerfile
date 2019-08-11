# Base Image
FROM appsvcorg/wordpress-alpine-php:0.72

MAINTAINER vinodsunkara <snvvk.vinod@gmail.com>

# Installing ODBC & MySQL Server drivers

RUN apk add --no-cache --virtual .build-deps autoconf g++ pcre-dev make unixodbc-dev

RUN pecl install sqlsrv \
    && docker-php-ext-enable sqlsrv

RUN pecl install pdo_sqlsrv \
    && docker-php-ext-enable pdo_sqlsrv

RUN echo "extension= pdo_sqlsrv.so" >> `php --ini | grep "Loaded Configuration" | sed -e "s|.*:\s*||"`\
RUN echo "extension= sqlsrv.so" >> `php --ini | grep "Loaded Configuration" | sed -e "s|.*:\s*||"` \
