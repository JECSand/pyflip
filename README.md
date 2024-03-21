# pyflip

## Getting Started
### Install Requirements
```shell
pip install -r requirements.txt
```

### Run Docker Standalone Locally
```shell
docker compose -f docker/standalone-compose.yml up -d

docker exec -it pulsar ./bin/pulsar-admin brokers healthcheck

docker exec -it pulsar /init-pulsar-topics.sh
docker exec -it pulsar /init-pulsar-connectors.sh
docker exec -it pulsar /init-pulsar-functions.sh

docker exec -it pulsar ./bin/pulsar-client consume -s test-sub3 -n 0 'persistent://public/default/mongo-topic-out'
docker exec -it pulsar ./bin/pulsar-client consume -s test-sub5 -n 0 'persistent://public/default/mongo-sink'


docker exec -it docker-jobmanager-1 wget -P /opt/flink/lib https://repo1.maven.org/maven2/io/streamnative/connectors/flink-sql-connector-pulsar/1.16.0.0/flink-sql-connector-pulsar-1.16.0.0.jar
docker exec -it docker-taskmanager-1 wget -P /opt/flink/lib https://repo1.maven.org/maven2/io/streamnative/connectors/flink-sql-connector-pulsar/1.16.0.0/flink-sql-connector-pulsar-1.16.0.0.jar

docker exec -it docker-jobmanager-1 wget -P /opt/flink/lib https://repo1.maven.org/maven2/org/apache/flink/flink-connector-pulsar/4.1.0-1.18/flink-connector-pulsar-4.1.0-1.18.jar
docker exec -it docker-taskmanager-1 wget -P /opt/flink/lib https://repo1.maven.org/maven2/org/apache/flink/flink-connector-pulsar/4.1.0-1.18/flink-connector-pulsar-4.1.0-1.18.jar

docker exec -it docker-taskmanager-1 wget -P /opt/flink/lib https://repo1.maven.org/maven2/org/apache/flink/flink-connector-pulsar/4.1.0-1.18/flink-connector-pulsar-4.1.0-1.18.jar

docker exec -it docker-jobmanager-1 ./bin/sql-client.sh --jar /opt/flink/lib/flink-sql-connector-pulsar-1.16.0.0.jar
docker exec -it docker-jobmanager-1 ./bin/sql-client.sh --jar /opt/flink/lib/flink-connector-pulsar-4.1.0-1.18.jar

docker exec -it docker-jobmanager-1 /init-flink-cluster.sh
docker exec -it docker-taskmanager-1 /init-flink-cluster.sh

./flink-1.14.3/bin/flink run -py /flink/processes/example.py -pyclientexec venv.zip/venv/bin/python3 -pyexec venv.zip/venv/bin/python3 -—output “path_to\out.txt”

```


