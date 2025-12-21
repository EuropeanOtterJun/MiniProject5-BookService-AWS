#!/bin/bash

echo "Validating Nginx service..."

# Nginx 프로세스 확인
echo "Checking if Nginx is running..."
if ! systemctl is-active --quiet nginx; then
    echo "❌ Nginx is not running"
    
    echo ""
    echo "=== Systemd Status ==="
    systemctl status nginx --no-pager -l
    
    exit 1
fi

echo "✅ Nginx process is active"

# HTTP 응답 확인
echo "Testing HTTP response..."
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80/)

if [ "$RESPONSE" = "200" ]; then
    echo "✅ Nginx is responding (HTTP $RESPONSE)"
    
    # 실제 콘텐츠 미리보기
    echo ""
    echo "=== Response Preview ==="
    curl -s http://localhost:80/ | head -20
    
    # 파일 확인
    echo ""
    echo "=== Deployed Files ==="
    ls -la /var/www/html/ | head -10
    
    exit 0
else
    echo "❌ Nginx health check failed (HTTP $RESPONSE)"
    
    echo ""
    echo "=== Nginx Status ==="
    systemctl status nginx --no-pager -l
    
    echo ""
    echo "=== Error Log ==="
    tail -30 /var/log/nginx/error.log
    
    echo ""
    echo "=== Access Log ==="
    tail -30 /var/log/nginx/access.log
    
    echo ""
    echo "=== Deployed Files ==="
    ls -la /var/www/html/
    
    echo ""
    echo "=== Nginx Configuration ==="
    cat /etc/nginx/conf.d/nginx.conf 2>/dev/null || cat /etc/nginx/conf.d/default.conf 2>/dev/null || echo "No config found"
    
    exit 1
fi