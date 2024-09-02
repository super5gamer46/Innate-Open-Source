# Use the official PHP image from Docker Hub
FROM php:8.0-apache

# Install required packages and PHP extensions
RUN apt-get update && \
    apt-get install -y \
        zlib1g-dev \
        libzip-dev \
        git \
        curl && \
    docker-php-ext-install zip && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory to the root directory
WORKDIR /var/www/html

# Copy all files from the client directory to the container's root directory
COPY ./client/ ./

# Copy server files to the container
COPY ./server/ /var/www/html/server/

# Set the working directory to the server directory
WORKDIR /var/www/html/server

# Ensure Apache has write permissions to the server directory and its contents
RUN chown -R www-data:www-data /var/www/html/server && \
    chmod -R 755 /var/www/html/server

# Expose port 80 for Apache
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
