# 1. Presto Commands
```sql
SHOW CATALOGS;
SHOW SCHEMAS FROM catalog;
SHOW TABLES  FROM catalog.schema;
SHOW COLUMNS FROM catalog.schema.table;
SHOW CREATE TABLE table_name;

USE catalog.schema;

CREATE TABLE new_table AS
SELECT *
FROM old_table
[WITH NO DATA]
```
