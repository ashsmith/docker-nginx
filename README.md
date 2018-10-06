# ashsmith/nginx

[![CircleCI](https://circleci.com/gh/ashsmith/docker-nginx/tree/master.svg?style=svg)](https://circleci.com/gh/ashsmith/docker-nginx/tree/master)

This is a basic nginx image, with php-fpm upstream configuration out of the box.

If you want to use https, just set the USE_HTTPS=true environment variable. 
You'll then need to mount your certificate and key file to: `/etc/nginx/ssl/default.crt` and `/etc/nginx/ssl/default.key`.

If you wish to provide your own configuration that goes into the `server` block, you can mount a file to: `/var/www/nginx.d/default.conf`.

If you wish to see what defaults have already been configured, you can see: `config/default-php.conf` in this repo.

## Looking for PHP images?

Have a look at: [ashsmith/docker-php](https://github.com/ashsmith/docker-php)

## What tags are in use?

Currently I'm just building using the latest tag from the base nginx version.

I do plan to add support for 1.15 and 1.14 explicitly in the near future.