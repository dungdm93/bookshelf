FROM gradle:9.4.1 AS downloader
SHELL ["/bin/bash", "-c"]
RUN mkdir -p /build/plugins
WORKDIR /build/

COPY ./build.gradle.kts /build/
RUN --mount=type=cache,target=/home/gradle/.gradle,id=gradle-cache  \
    gradle --no-daemon\
        dependencies --configuration runtimeClasspath \
        copyDeps -PoutDir=plugins/confluent-schema-registry/;

FROM quay.io/debezium/connect:3.5.0.Final

COPY --from=downloader /build/plugins /kafka/connect
