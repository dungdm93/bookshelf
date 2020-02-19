# 1. Tutorial
1. Create `debezium` user in MySQL
    ```bash
    mysql --user=root --password=SuperSecr3t --protocol=tcp < res/mysql-user.sql
    ```

2. Create `kafka` bucket on MinIO
    ```bash
    mc config host add local http://localhost:9000 admin SuperSecr3t
    mc mb local/kafka
    ```

3. Create `sample_mysql` kafka connector to stream data change from MySQL
    ```bash
    curl -i -X POST http://localhost:8083/connectors/ \
        -H "Accept:application/json" \
        -H "Content-Type:application/json" \
        -d @res/register-mysql.json
    ```

3. Create `sample_s3` kafka connector to stream data change to MinIO
    ```bash
    curl -i -X POST http://localhost:8083/connectors/ \
        -H "Accept:application/json" \
        -H "Content-Type:application/json" \
        -d @res/register-s3.json
    ```
