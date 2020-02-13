# 1. Debezium
## 1.1 API
```bash
curl -i -X POST http://localhost:8083/connectors/ \
    -H "Accept:application/json" \
    -H "Content-Type:application/json" \
    -d @mysql/register.json
```
