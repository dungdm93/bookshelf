## 1. Kafka
```bash
export BOOTSTRAP_SERVER=host:port,...
export TOPIC=name

./bin/kafka-server-start.sh config/server.properties
./bin/kafka-server-stop.sh

./bin/kafka-topics.sh --bootstrap-server="${BOOTSTRAP_SERVER}" --list
./bin/kafka-topics.sh --bootstrap-server="${BOOTSTRAP_SERVER}" --create   --topic="${TOPIC}" --replication-factor=<num> --partitions=<num>
./bin/kafka-topics.sh --bootstrap-server="${BOOTSTRAP_SERVER}" --describe --topic="${TOPIC}"

./bin/kafka-console-producer.sh --broker-list="${BOOTSTRAP_SERVER}"      --topic="${TOPIC}"
./bin/kafka-console-consumer.sh --bootstrap-server="${BOOTSTRAP_SERVER}" --topic="${TOPIC}" --from-beginning
```
