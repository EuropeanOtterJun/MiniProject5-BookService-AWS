#!/bin/bash

echo "Starting Nginx..."

# Nginx 재시작 (start 대신 restart 사용)
echo "Restarting Nginx service..."
systemctl restart nginx

# 부팅 시 자동 시작 설정
systemctl enable nginx

# 시작 대기
sleep 3

# 상태 확인
if systemctl is-active --quiet nginx; then
    echo "✅ Nginx is running"
    
    # 상태 정보
    echo ""
    echo "=== Nginx Status ==="
    systemctl status nginx --no-pager -l
    
    # 포트 확인
    echo ""
    echo "=== Listening Ports ==="
    netstat -tlnp | grep nginx || ss -tlnp | grep nginx
    
    # 로컬 테스트
    echo ""
    echo "=== Testing localhost ==="
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:80/)
    echo "HTTP Response: $HTTP_CODE"
    
    if [ "$HTTP_CODE" = "200" ]; then
        echo "✅ Nginx is responding correctly"
    else
        echo "⚠️ Warning: Unexpected HTTP code $HTTP_CODE"
    fi
    
    exit 0
else
    echo "❌ ERROR: Nginx failed to start"
    
    echo ""
    echo "=== Systemd Status ==="
    systemctl status nginx --no-pager -l
    
    echo ""
    echo "=== Nginx Error Log ==="
    tail -50 /var/log/nginx/error.log
    
    echo ""
    echo "=== Nginx Access Log ==="
    tail -20 /var/log/nginx/access.log
    
    exit 1
fi