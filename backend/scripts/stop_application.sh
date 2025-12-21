#!/bin/bash

echo "Stopping AIVLE backend..."

if [ -f /home/ec2-user/app/application.pid ]; then
    PID=$(cat /home/ec2-user/app/application.pid)
    if ps -p $PID > /dev/null; then
        echo "Stopping PID: $PID"
        kill -15 $PID
        
        for i in {1..60}; do
            if ! ps -p $PID > /dev/null; then
                echo "Stopped successfully"
                break
            fi
            sleep 1
        done
        
        if ps -p $PID > /dev/null; then
            kill -9 $PID
        fi
    fi
    rm -f /home/ec2-user/app/application.pid
fi

if pgrep -f "aivle.*\.jar" > /dev/null; then
    pkill -f "aivle.*\.jar"
fi

exit 0