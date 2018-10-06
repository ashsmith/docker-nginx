#!/bin/bash


############################################
# Configure /etc/nginx/conf.d/default.conf #
############################################
TEMPLATE_FILE="/etc/nginx/conf.d/default-http.conf.template"
if [ "$USE_HTTPS" == "true" ]
then
  TEMPLATE_FILE="/etc/nginx/conf.d/default-https.conf.template"
fi

VHOST_FILE="/etc/nginx/conf.d/default.conf"
cp $TEMPLATE_FILE $VHOST_FILE

[ ! -z "${FPM_HOST}" ] && sed -i "s|{{FPM_HOST}}|${FPM_HOST}|" $VHOST_FILE
[ ! -z "${FPM_PORT}" ] && sed -i "s|{{FPM_PORT}}|${FPM_PORT}|" $VHOST_FILE

###########################################
# Configure /var/www/nginx.d/default.conf #
###########################################
INCLUDE_TEMPLATE="/var/www/nginx.d/default.conf.template"
INCLUDE_FILE="/var/www/nginx.d/default.conf"
cp $INCLUDE_TEMPLATE $INCLUDE_FILE

[ ! -z "${UPLOAD_MAX_FILESIZE}" ] && sed -i "s|{{UPLOAD_MAX_FILESIZE}}|${UPLOAD_MAX_FILESIZE}|" $INCLUDE_FILE
[ ! -z "${PHP_MEMORY_LIMIT}" ] && sed -i "s|{{PHP_MEMORY_LIMIT}}|${PHP_MEMORY_LIMIT}|" $INCLUDE_FILE
[ ! -z "${PHP_MAX_EXECUTION_TIME}" ] && sed -i "s|{{PHP_MAX_EXECUTION_TIME}}|${PHP_MAX_EXECUTION_TIME}|" $INCLUDE_FILE

# Check if the nginx syntax is fine, then launch.
nginx -t

exec "$@"