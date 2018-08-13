FROM webdevops/php-nginx:latest

MAINTAINER Ajay Bhosale<ajay.bhosale@silicus.com>

# Pull Source Code
COPY index.php /var/www/html/

# Laravel required commands
WORKDIR /var/www/html/