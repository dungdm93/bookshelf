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
