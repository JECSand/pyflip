#!/usr/bin/env sh

docker exec -it docker-jobmanager-1 wget -P /opt/flink/lib https://repo1.maven.org/maven2/io/streamnative/connectors/flink-sql-connector-pulsar/1.16.0.0/flink-sql-connector-pulsar-1.16.0.0.jar
docker exec -it docker-taskmanager-1 wget -P /opt/flink/lib https://repo1.maven.org/maven2/io/streamnative/connectors/flink-sql-connector-pulsar/1.16.0.0/flink-sql-connector-pulsar-1.16.0.0.jar
# docker exec -it docker-jobmanager-1 ./bin/sql-client.sh embedded --jar /opt/flink/lib/flink-sql-connector-pulsar-1.16.0.0.jar --file /tmp/dbSetup.sql