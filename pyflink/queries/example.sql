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