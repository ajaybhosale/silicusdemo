FROM phnxditeastuscr.azurecr.io/phnx-dit-base:v1

MAINTAINER Ajay Bhosale<ajay.bhosale@silicus.com>

# Pull Source Code
COPY workspace /var/www/html/workspace

# Laravel required commands
WORKDIR /var/www/html/workspace

RUN chmod 777 .env && \
	chmod -R 777 storage && \	 
	php artisan cache:clear