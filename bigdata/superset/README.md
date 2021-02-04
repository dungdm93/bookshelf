Apache Superset
===============

## 1. Bootstrap
```bash
docker-compose up -d

# Create an admin user
docker-compose exec superset-webserver superset fab create-admin

# Create default roles and permissions
docker-compose exec superset-webserver superset init

# Load some data to play with
docker-compose exec superset-webserver superset load_examples
```
