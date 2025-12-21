#!/bin/bash

echo "Before install - Backend"

if [ -d /home/ec2-user/app ]; then
    rm -f /home/ec2-user/app/*.jar
    rm -f /home/ec2-user/app/application.pid
fi

mkdir -p /home/ec2-user/app
mkdir -p /var/log/myapp

if ! java -version 2>&1 | grep -q "17"; then
    yum install -y java-17-amazon-corretto-headless
fi

exit 0