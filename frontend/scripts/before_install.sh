#!/bin/bash

echo "Before install - Frontend"

# 기존 파일 삭제
echo "Cleaning up old files..."
rm -rf /var/www/html/*

# Nginx 설치 확인
if ! command -v nginx &> /dev/null; then
    echo "Nginx not found. Installing..."
    
    # Amazon Linux 2023의 경우
    yum install -y nginx
    
    # 또는 Amazon Linux 2의 경우
    amazon-linux-extras enable nginx1 2>/dev/null || true
    yum install -y nginx 2>/dev/null || true
fi

# Nginx 버전 확인
echo "Nginx version:"
nginx -v

# 디렉토리 생성
echo "Creating directories..."
mkdir -p /var/www/html
mkdir -p /etc/nginx/conf.d

# 기본 Nginx 설정 백업 (처음 한 번만)
if [ -f /etc/nginx/nginx.conf ] && [ ! -f /etc/nginx/nginx.conf.backup ]; then
    echo "Backing up default Nginx configuration..."
    cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
fi

echo "Before install completed successfully"
exit 0