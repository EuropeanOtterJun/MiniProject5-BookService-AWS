#!/bin/bash

echo "Starting AIVLE backend..."

cd /home/ec2-user/app

JAR_FILE=$(ls *.jar | grep -v plain | head -n 1)

export SPRING_PROFILES_ACTIVE=prod
export SERVER_PORT=8000

# 환경변수 로드
if [ -f /home/ec2-user/.env ]; then
    set -a
    source /home/ec2-user/.env
    set +a
fi

nohup java -jar \
    -Dspring.profiles.active=prod \
    -Xms512m -Xmx1024m \
    $JAR_FILE \
    # > /var/log/myapp/application.log 2>&1 &
    > /home/ec2-user/application.log 2>&1 & # 경로를 홈 디렉토리로 변경 권장

echo $! > application.pid

sleep 15

exit 0