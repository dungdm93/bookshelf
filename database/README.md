## 1. MongoDB
### 1.1 MongoDB Shell
```bash
$ mongo --authenticationDatabase=admin --username="${MONGO_INITDB_ROOT_USERNAME}" --password="${MONGO_INITDB_ROOT_PASSWORD}"
mongo> show dbs | databases
mongo> use <db>
mongo> show collections
mongo> show users | roles
```

ref: [mongo-shell](https://docs.mongodb.com/manual/reference/mongo-shell/)

### 1.2 Backup / Restore
#### 1.2.1 Export / Import from JSON/CSV file
```bash
$ mongoexport --db=DATABASE --collection=COLLECTION [--drop] \
   --type=<json | csv | tsv> [--jsonArray] [--pretty] \
   --out=<filename>

$ mongoimport --db=DATABASE --collection=COLLECTION [--drop] \
   --type=<json | csv | tsv> [--jsonArray] [--drop] \
   --file=<filename>
```

#### 1.2.2 Dump / Restore
```bash
$ mongodump [--db=DATABASE] [--collection=COLLECTION] [--gzip] [--out=<dir-path>]
$ tree dump/
`-- DATABASE
    |-- COLLECTION.bson
    |-- COLLECTION.metadata.json
$ mongorestore [--dir=/path/to/dump/]
$ mongorestore --db=DATABASE /path/to/dump/DATABASE
$ mongorestore --db=DATABASE --collection=COLLECTION /path/to/dump/DATABASE/COLLECTION.bson
```

#### 1.2.2 Dump / Restore from single file
```bash
$ mongodump    [--db=DATABASE] [--collection=COLLECTION] --gzip --archive=/path/to/DATABASE.gz
$ mongorestore [--db=DATABASE] [--collection=COLLECTION] --gzip --archive=/path/to/DATABASE.gz
```

## 2. MySQL
### 2.1 `mysql` cli
```sql
SHOW DATABASES;
USE <database>;
SHOW TABLES; -- tables + views
SHOW FULL TABLES WHERE table_type != 'VIEW';
SHOW CREATE TABLE <table>;

-- Note: 'username' is a synonym for 'username'@'%'
SELECT user, host, plugin, authentication_string FROM mysql.user;
SHOW GRANTS [FOR <user>];

CREATE USER 'username'@'host' IDENTIFIED BY 'password';
GRANT ALL ON database.table TO <user>;
GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO <user>;


SHOW VARIABLES [LIKE 'binlog_format'];
```

### 2.2 