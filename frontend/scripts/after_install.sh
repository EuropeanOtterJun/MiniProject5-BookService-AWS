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

# nginx.conf 파일 확인 (destination이 디렉토리이므로 원본 파일명 유지)
if [ -f /etc/nginx/conf.d/nginx.conf ]; then
    echo "✅ Nginx configuration found at /etc/nginx/conf.d/nginx.conf"
    
    echo "Configuration content:"
    cat /etc/nginx/conf.d/nginx.conf
    
    # default.conf로 심볼릭 링크 또는 복사 (필요시)
    if [ ! -f /etc/nginx/conf.d/default.conf ]; then
        echo "Creating symlink: default.conf -> nginx.conf"
        ln -sf /etc/nginx/conf.d/nginx.conf /etc/nginx/conf.d/default.conf
    fi
    
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