#!/usr/bin/env bash
memory(){
  #top -n 1 -b  | grep -E " hbase| impala| hdfs| yarn| hue| spark| yarn| zook|^hiveeeper" | grep -vE "grep"  | sort  -k 2  | awk -v time="$(date +"%y%m%d-%H%M%S" -d '-1 minute')" '{print("\""time"\",\""$2"\",\""$9"\",\""$10"\",\""$12"\"")}' >> $1
  #ps -auxh | grep -E "^hbase|^impala|^hdfs|^yarn|^hue|^spark|^yarn|^zookeeper" | grep -vE "grep" |sort -k 1 | awk -v time="$(date +"%y%m%d-%H%M%S" -d '-1 minute')" '{print("\""time"\",\""$1"\",\""$3"\",\""$4"\",\""$11"\"")}' >> $1
  z=$(ps aux|grep -E "^hbase|^impala|^hdfs|^yarn|^hue|^spark|^yarn|^zookeeper|^hive" | grep -vE "grep")
  while read -r z
  do
     var=$var$(awk '{print "memory_cloudera{process=\""$11"\", pid=\""$2"\", user=\""$1"\"}", $4z}');
  done <<< "$z"
  curl -X POST -H  "Content-Type: text/plain" --data "$var
  " http://10.50.166.92:9091/metrics/job/top/cloudera/$(hostname)
}
memory $1

