#!/bin/bash

echo "Starting Nginx..."

# Nginx 시작
systemctl start nginx

# 부팅 시 자동 시작 설정
systemctl enable nginx

# 상태 확인
sleep 3

if systemctl is-active --quiet nginx; then
    echo "✅ Nginx is running"
    
    # 설정 확인
    echo "Nginx status:"
    systemctl status nginx --no-pager
    
    # 포트 확인
    echo "Listening ports:"
    netstat -tlnp | grep nginx
    
    exit 0
else
    echo "❌ ERROR: Nginx failed to start"
    
    # 에러 로그 출력
    echo "Nginx error log:"
    tail -50 /var/log/nginx/error.log
    
    exit 1
fi