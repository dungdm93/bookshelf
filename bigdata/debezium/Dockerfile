FROM maven:3.9-eclipse-temurin-21-alpine AS downloader
SHELL ["/bin/bash", "-c"]
RUN mkdir -p /build/plugins
WORKDIR /build/

COPY ./pom.xml /build/
RUN --mount=type=cache,target=/root/.m2/repository,id=maven-cache  \
    mvn dependency:resolve \
        dependency:copy-dependencies -DoutputDirectory=plugins/confluent-schema-registry/;

FROM quay.io/debezium/connect:3.5.0.Final

COPY --from=downloader /build/plugins /kafka/connect
