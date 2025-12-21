#!/bin/bash

echo "After install - Frontend"

# 1. 권한 설정
chown -R nginx:nginx /var/www/html
chmod -R 755 /var/www/html

# 2. Nginx 설정 파일 존재 여부 확인 및 테스트
if [ -f /etc/nginx/conf.d/default.conf ]; then
    echo "✅ Nginx configuration found. Testing..."
    nginx -t
else
    echo "❌ ERROR: Nginx configuration not found at /etc/nginx/conf.d/default.conf!"
    exit 1
fi

exit 0