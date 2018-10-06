ARG VERSION=latest
FROM nginx:${VERSION}

ENV FPM_HOST fpm
ENV FPM_PORT 9000
ENV UPLOAD_MAX_FILESIZE 64M
ENV PHP_MEMORY_LIMIT 756M
ENV PHP_MAX_EXECUTION_TIME 18000
ENV USE_HTTPS false

# Create root directories, and ensure owner/group is set to new app user.
RUN mkdir -p /var/www/html /var/www/nginx.d

# Our main entrypoint will replace variables in the nignx templates.
ADD bin/entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Copy base server templates
ADD config/default-server-http.conf /etc/nginx/conf.d/default-http.conf.template
ADD config/default-server-https.conf /etc/nginx/conf.d/default-https.conf.template

# Copy in the default configuration for php/fpm.
ADD config/default-php.conf /var/www/nginx.d/default.conf.template

CMD ["nginx", "-g", "daemon off;"]