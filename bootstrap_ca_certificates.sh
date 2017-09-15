export CA_HOME=$PWD/files/ElasticCA
export LOGSTASH_IP=192.168.33.8

mkdir $CA_HOME
$PWD/files/ca-scripts/bin/ca-init -f $PWD/ca-scripts.conf
$PWD/files/ca-scripts/bin/ca-create-cert -f $PWD/ca-scripts.conf -i $LOGSTASH_IP logstash
$PWD/files/ca-scripts/bin/ca-create-cert -f $PWD/ca-scripts.conf -t client filebeat
