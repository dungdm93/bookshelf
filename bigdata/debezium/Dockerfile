ARG BASE_IMAGE
FROM ${BASE_IMAGE}

RUN set -eux; \
    confluent-hub install debezium/debezium-connector-mysql:1.0.0      --no-prompt; \
    confluent-hub install debezium/debezium-connector-postgresql:1.0.0 --no-prompt; \
    confluent-hub install debezium/debezium-connector-sqlserver:1.0.0  --no-prompt; \
    confluent-hub install debezium/debezium-connector-mongodb:1.0.0    --no-prompt;
