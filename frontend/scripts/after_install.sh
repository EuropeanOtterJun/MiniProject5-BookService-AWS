#!/bin/bash

echo "After install - Frontend"

# 소유권 설정
echo "Setting ownership..."
chown -R nginx:nginx /var/www/html

# 권한 설정
echo "Setting permissions..."
chmod -R 755 /var/www/html

# 배포된 파일 확인
echo "Deployed files:"
ls -la /var/www/html/

# Nginx 설정 파일 확인
echo "Checking Nginx configuration..."

if [ -f /etc/nginx/conf.d/default.conf ]; then
    echo "✅ Nginx configuration found"
    echo "Configuration content:"
    cat /etc/nginx/conf.d/default.conf
    
    echo "Testing Nginx configuration..."
    nginx -t
    
    if [ $? -ne 0 ]; then
        echo "❌ ERROR: Nginx configuration test failed!"
        exit 1
    fi
    
    echo "✅ Nginx configuration is valid"
else
    echo "❌ ERROR: Nginx configuration not found!"
    echo "Checking /etc/nginx/conf.d/ directory:"
    ls -la /etc/nginx/conf.d/
    exit 1
fi

exit 0