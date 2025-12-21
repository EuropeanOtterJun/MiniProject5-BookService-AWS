#!/bin/bash

echo "After install - Backend"

cd /home/ec2-user/app

JAR_FILE=$(ls *.jar 2>/dev/null | grep -v plain | head -n 1)

if [ -z "$JAR_FILE" ]; then
    echo "ERROR: No JAR file found!"
    exit 1
fi

echo "Found: $JAR_FILE"
chmod +x $JAR_FILE

exit 0