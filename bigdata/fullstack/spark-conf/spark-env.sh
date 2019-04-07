JAVA_HOME="$(readlink -f /usr/bin/java | sed "s:/bin/java::")"

HADOOP_HOME="/opt/hadoop"
HADOOP_CONF_DIR="${HADOOP_CONF_DIR:-$HADOOP_HOME/etc/hadoop}"
YARN_CONF_DIR="${YARN_CONF_DIR:-$HADOOP_HOME/etc/hadoop}"
HDFS_CONF_DIR="${HDFS_CONF_DIR:-$HADOOP_HOME/etc/hadoop}"

SPARK_DIST_CLASSPATH="$(${HADOOP_HOME}/bin/hadoop classpath)"
# PYSPARK_DRIVER_PYTHON="/opt/conda/bin/python"
# PYSPARK_PYTHON="/opt/conda/bin/python"
#
# SPARK_MASTER_HOST=localhost
# SPARK_MASTER_PORT=7077
# SPARK_MASTER_WEBUI_PORT=8080
# SPARK_WORKER_WEBUI_PORT=8080
