FROM silicus.azurecr.io/silicus-php-dit:v1

MAINTAINER Ajay Bhosale<ajay.bhosale@silicus.com>

# Pull Source Code
COPY index.php /var/www/html/

# Laravel required commands
WORKDIR /var/www/html/