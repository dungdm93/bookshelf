#!/usr/bin/env bash

export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:/bin/java::")
export SPARK_VERSION=2.4.1
export SPARK_HOME=/opt/spark
export PYTHONPATH="${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-0.10.7-src.zip"
export PATH=${SPARK_HOME}/bin:${PATH}

alias ..='cd ..'

if command -v kubectl >/dev/null 2>&1; then
    source <(kubectl completion bash)
fi
