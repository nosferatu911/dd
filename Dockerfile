# Use an official PHP-FPM 8.1 image as the base image
FROM php:8.1-fpm

# Install any additional dependencies or extensions you need
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    # Add any additional packages here
    && rm -rf /var/lib/apt/lists/*

# Set the working directory to /var/www
WORKDIR /var/www

# Expose port 9000 to connect to PHP-FPM
EXPOSE 9000

CMD ["php-fpm"]
# Use an official Nginx image as the base image
FROM nginx:latest

# Install PHP-FPM and other necessary packages
RUN apt-get update && \
    apt-get install -y php8.1-fpm php8.1-common php8.1-cli && \
    rm -rf /var/lib/apt/lists/*

# Copy Nginx and PHP configuration files
COPY nginx.conf /etc/nginx/nginx.conf
COPY php-fpm.conf /etc/php/8.1/fpm/php-fpm.conf

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Expose port 80 for Nginx
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
