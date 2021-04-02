#!/usr/bin/env bash
memory(){
  z=$(ps aux|grep -E "^hbase|^impala|^hdfs|^yarn|^hue|^spark|^yarn|^zookeeper|^hive" | grep -vE "grep")
  while read -r z
  do
     var=$var$(awk '{print "memory_cloudera{process=\""$11"\", pid=\""$2"\", user=\""$1"\"}", $4z}');
  done <<< "$z"
  curl -X POST -H  "Content-Type: text/plain" --data "$var
  " http://10.50.166.92:9091/metrics/job/top/cloudera/$(hostname)
}
memory $1

