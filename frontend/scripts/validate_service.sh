#!/bin/bash

echo "Validating Nginx service..."

# Nginx 프로세스 확인
if ! systemctl is-active --quiet nginx; then
    echo "❌ Nginx is not running"
    exit 1
fi

# HTTP 응답 확인
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80/)

if [ "$RESPONSE" = "200" ]; then
    echo "✅ Nginx is responding (HTTP $RESPONSE)"
    exit 0
else
    echo "❌ Nginx health check failed (HTTP $RESPONSE)"
    
    # 디버깅 정보
    echo "Nginx status:"
    systemctl status nginx --no-pager
    
    echo "Error log:"
    tail -20 /var/log/nginx/error.log
    
    exit 1
fi