#!/bin/bash

MAX_RETRIES=10

for i in $(seq 1 $MAX_RETRIES); do
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/)
    
    if [ "$HTTP_CODE" -eq 200 ]; then
        echo "✅ Frontend validation passed"
        exit 0
    fi
    
    sleep 3
done

echo "❌ Validation failed"
exit 1