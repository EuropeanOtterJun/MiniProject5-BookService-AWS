#!/bin/bash

chown -R nginx:nginx /var/www/html
chmod -R 755 /var/www/html

nginx -t

exit 0