#!/bin/bash

echo "Validating backend service..."

MAX_RETRIES=30
RETRY_COUNT=0
HEALTH_URL="http://localhost:8000/actuator/health"

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" $HEALTH_URL)
    
    if [ "$HTTP_CODE" -eq 200 ]; then
        echo "✅ Health check passed!"
        exit 0
    fi
    
    RETRY_COUNT=$((RETRY_COUNT + 1))
    sleep 3
done

echo "❌ Validation failed"
tail -100 /var/log/myapp/application.log
exit 1