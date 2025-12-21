#!/bin/bash
echo "Validating backend service..."

MAX_RETRIES=20
RETRY_COUNT=0
# Actuator가 없다면 아래 주소를 "http://localhost:8000/" 로 바꾸세요
HEALTH_URL="http://localhost:8000/actuator/health"

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" $HEALTH_URL)
    
    if [ "$HTTP_CODE" -eq 200 ]; then
        echo "✅ Health check passed!"
        exit 0
    fi
    
    echo "Attempting health check... (HTTP $HTTP_CODE) - Retry $RETRY_COUNT/$MAX_RETRIES"
    RETRY_COUNT=$((RETRY_COUNT + 1))
    sleep 5
done

echo "❌ Validation failed. Printing application logs for debugging:"
if [ -f /var/log/myapp/application.log ]; then
    tail -n 100 /var/log/myapp/application.log
else
    echo "Log file not found at /var/log/myapp/application.log"
fi
exit 1