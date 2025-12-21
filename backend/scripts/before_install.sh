#!/bin/bash
echo "Before install - Backend"

# 기존 앱 삭제 및 폴더 생성
if [ -d /home/ec2-user/app ]; then
    rm -f /home/ec2-user/app/*.jar
fi

mkdir -p /home/ec2-user/app
mkdir -p /var/log/myapp

# 로그 폴더와 앱 폴더 소유권을 ec2-user로 명확히 변경
chown -R ec2-user:ec2-user /home/ec2-user/app
chown -R ec2-user:ec2-user /var/log/myapp

# Java 17 설치 확인
if ! java -version 2>&1 | grep -q "17"; then
    sudo yum install -y java-17-amazon-corretto-headless
fi

exit 0