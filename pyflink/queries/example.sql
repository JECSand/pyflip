-- SourceStream
CREATE TABLE sample.ships_source (
                                     id INT,
                                     name STRING,
                                     age INT,
                                     income DOUBLE,
                                     single BOOLEAN,
                                     createTime BIGINT,
                                     row_time AS CAST(TO_TIMESTAMP(FROM_UNIXTIME(createTime / 1000), 'yyyy-MM-dd HH:mm:ss') AS TIMESTAMP(3)),
                                     WATERMARK FOR row_time AS row_time - INTERVAL '5' SECOND
) WITH (
    'connector' = 'pulsar',
    'admin-url' = 'http://pulsar:8080',
    'service-url' = 'pulsar://pulsar:6650',
    'topics' = 'persistent://sample/flink/user',
    'scan.startup.mode' = 'earliest',
    'format' = 'json'
);


-- SinkStream
CREATE TABLE sample.users_sink (
                                  id INT,
                                  name STRING,
                                  age INT,
                                  income DOUBLE,
                                  averageIncome DOUBLE,
                                  single BOOLEAN,
                                  createTime BIGINT
) WITH (
    'connector' = 'pulsar',
    'admin-url' = 'http://pulsar:8080',
    'service-url' = 'pulsar://pulsar:6650',
    'topics' = 'persistent://sample/flink/sink-user',
    'format' = 'json'
);


-- Insert enriched changes to sink table
INSERT INTO sample.users_sink
SELECT
    u.id,
    u.name,
    u.age,
    u.income,
    a.averageIncome,
    u.single,
    u.createTime,
    u.row_time
FROM sample.users u
INNER JOIN sample.users_aggregates a
ON u.id = a.id;