#!/bin/bash

namedir=$(${HADOOP_HOME}/bin/hdfs getconf -confKey dfs.namenode.name.dir | sed -E 's#file:(//)?##')

function start_namenode() {
  if [ ! -d "$namedir" ] || [ -z "$(ls -A "$namedir")" ]; then
    echo "Formatting NameNode directory: $namedir"
    ${HADOOP_HOME}/bin/hdfs namenode -format -nonInteractive
  else
    echo "NameNode directory already existed"
    echo "!!! SKIP !!!"
  fi

  ${HADOOP_HOME}/bin/hdfs namenode
}

function start_datanode() {
  ${HADOOP_HOME}/bin/hdfs datanode
}

case $1 in
  namenode)
    start_namenode
  ;;
  datanode)
    start_datanode
  ;;
  *)
    exec "$@"
  ;;
esac
