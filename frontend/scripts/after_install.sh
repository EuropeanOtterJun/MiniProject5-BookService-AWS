#!/bin/bash

echo "After install - Frontend"

# 권한 설정
chown -R nginx:nginx /var/www/html
chmod -R 755 /var/www/html

# Nginx 설정 파일 확인
if [ -f /etc/nginx/conf.d/default.conf ]; then
    echo "✅ Nginx configuration found at /etc/nginx/conf.d/default.conf"
    nginx -t
else
    echo "❌ ERROR: Nginx configuration not found!"
    exit 1
fi

exit 0