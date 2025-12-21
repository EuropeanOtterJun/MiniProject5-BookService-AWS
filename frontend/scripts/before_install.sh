#!/bin/bash

echo "Before install - Frontend"

# 기존 파일 삭제
echo "Cleaning up old files..."
rm -rf /var/www/html/*

# 기존 Nginx 설정 강제 제거 (디렉토리/파일 모두)
echo "Removing old Nginx configuration..."
rm -rf /etc/nginx/conf.d/default.conf
rm -f /etc/nginx/conf.d/default.conf
rm -f /etc/nginx/conf.d/nginx.conf

# Nginx 설치 확인
if ! command -v nginx &> /dev/null; then
    echo "Nginx not found. Installing..."
    yum install -y nginx
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