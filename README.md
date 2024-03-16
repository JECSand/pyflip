# pyflip

## Getting Started
### Install Requirements
```shell
pip install -r requirements.txt
```

### Run Docker Standalone Locally
```shell
docker compose -f docker/standalone-compose.yml up -d

docker exec -it pulsar /init-pulsar-connectors.sh
docker exec -it pulsar /init-pulsar-functions.sh

docker exec -it pulsar ./bin/pulsar-client consume -s test-sub -n 0 'persistent://public/default/mongo-topic'
docker exec -it pulsar ./bin/pulsar-client consume -s test-sub -n 0 'persistent://public/default/ExampleFunction_logs'

```

