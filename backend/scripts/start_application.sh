#!/bin/bash

echo "=== Starting AIVLE Backend ==="

# 환경변수 로드 (필수!)
if [ -f /home/ec2-user/.env ]; then
    echo "Loading environment variables..."
    source /home/ec2-user/.env
    
    # 환경변수 확인
    echo "✓ DB_HOST: $DB_HOST"
    echo "✓ DB_NAME: $DB_NAME"
    echo "✓ DB_USER: $DB_USER"
    echo "✓ DB_PASSWORD: [HIDDEN]"
else
    echo "❌ ERROR: .env file not found!"
    exit 1
fi

cd /home/ec2-user/app

# JAR 파일 찾기 (plain.jar 제외!)
JAR_FILE=$(ls *.jar 2>/dev/null | grep -v plain | head -n 1)

if [ -z "$JAR_FILE" ]; then
    echo "❌ ERROR: No executable JAR file found!"
    echo "Available files:"
    ls -lh *.jar
    exit 1
fi

echo "✓ Found JAR: $JAR_FILE"

# 기존 PID 파일 확인
if [ -f application.pid ]; then
    OLD_PID=$(cat application.pid)
    if ps -p $OLD_PID > /dev/null 2>&1; then
        echo "⚠ Old process still running (PID: $OLD_PID), stopping..."
        kill -15 $OLD_PID
        sleep 3
        if ps -p $OLD_PID > /dev/null 2>&1; then
            kill -9 $OLD_PID
        fi
    fi
    rm -f application.pid
fi

echo "Starting Spring Boot application..."

# Spring Boot 실행
nohup java -jar \
    -Dspring.profiles.active=prod \
    -Dserver.port=8000 \
    -Xms512m -Xmx1024m \
    "$JAR_FILE" \
    > /var/log/myapp/application.log 2>&1 &

# PID 저장
PID=$!
echo $PID > application.pid

echo "✓ Application started with PID: $PID"

# 시작 확인 (10초 대기)
echo "Waiting for application to start..."
sleep 10

# 프로세스 확인
if ps -p $PID > /dev/null 2>&1; then
    echo "✅ Application is running!"
    echo ""
    echo "=== Recent Log Output ==="
    tail -30 /var/log/myapp/application.log
    echo ""
    echo "=== Health Check ==="
    curl -s http://localhost:8000/actuator/health || echo "Health check endpoint not ready yet"
    exit 0
else
    echo "❌ ERROR: Application failed to start!"
    echo ""
    echo "=== Last 50 lines of log ==="
    tail -50 /var/log/myapp/application.log
    exit 1
fi