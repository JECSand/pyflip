CREATE CATALOG pulsar
  WITH (
    'type' = 'pulsar-catalog',
    'catalog-admin-url' = 'http://pulsar:8080',
    'catalog-service-url' = 'pulsar://pulsar:6650'
  );
CREATE DATABASE sample;