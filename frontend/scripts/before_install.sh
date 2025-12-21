#!/bin/bash

echo "Before install - Frontend"

# 기존 파일 삭제
rm -rf /var/www/html/*

# Nginx 설치 확인
if ! command -v nginx &> /dev/null; then
    echo "Installing Nginx..."
    amazon-linux-extras enable nginx1 2>/dev/null || true
    yum install -y nginx
fi

# 디렉토리 생성
mkdir -p /var/www/html

exit 0