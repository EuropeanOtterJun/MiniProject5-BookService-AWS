#!/bin/bash
echo "Starting AIVLE backend..."
cd /home/ec2-user/app

# 실행할 JAR 파일 찾기
JAR_FILE=$(ls *.jar | grep -v plain | head -n 1)

# 앱 실행 (로그 경로 및 백그라운드 처리)
nohup java -jar \
    -Dspring.profiles.active=prod \
    -Xms512m -Xmx1024m \
    $JAR_FILE \
    > /var/log/myapp/application.log 2>&1 &

# PID 저장
echo $! > application.pid
echo "Application started with PID: $(cat application.pid)"

sleep 10
exit 0