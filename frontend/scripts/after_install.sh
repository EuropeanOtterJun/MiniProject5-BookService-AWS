#!/bin/bash

echo "After install - Frontend"

# 소유권 설정
chown -R nginx:nginx /var/www/html

# 권한 설정
chmod -R 755 /var/www/html

# Nginx 설정 파일 확인
if [ -f /etc/nginx/conf.d/default.conf ]; then
    echo "✓ Nginx configuration updated"
    cat /etc/nginx/conf.d/default.conf
else
    echo "✗ ERROR: Nginx configuration not found!"
    exit 1
fi

# Nginx 설정 테스트
nginx -t

if [ $? -ne 0 ]; then
    echo "✗ ERROR: Nginx configuration test failed!"
    exit 1
fi

echo "✓ Nginx configuration is valid"

exit 0