from pyflink.common import SimpleStringSchema, WatermarkStrategy
from pyflink.datastream import StreamExecutionEnvironment
from pyflink.datastream.connectors import DeliveryGuarantee
# from pyflink.table import StreamTableEnvironment, DataTypes
from pyflink.datastream.connectors.pulsar import PulsarSource, PulsarSink, StartCursor

# https://github.com/apache/flink-connector-pulsar/blob/main/docs/content/docs/connectors/datastream/pulsar.md
pulsar_source = PulsarSource.builder() \
    .set_service_url('pulsar://localhost:6650') \
    .set_admin_url('http://localhost:8080') \
    .set_start_cursor(StartCursor.earliest()) \
    .set_topics("flink-process") \
    .set_deserialization_schema(SimpleStringSchema()) \
    .set_subscription_name('flink-subscription') \
    .build()

pulsar_sink = PulsarSink.builder() \
    .set_service_url('pulsar://localhost:6650') \
    .set_admin_url('http://localhost:8080') \
    .set_topics("flink-out") \
    .set_serialization_schema(SimpleStringSchema()) \
    .set_delivery_guarantee(DeliveryGuarantee.AT_LEAST_ONCE) \
    .build()


def main():
    env = StreamExecutionEnvironment.get_execution_environment()
    # t_env = StreamTableEnvironment.create(env)
    ds = env.from_source(source=pulsar_source,
                         watermark_strategy=WatermarkStrategy.for_monotonous_timestamps(),
                         source_name="pulsar source")
    print("Printing result to stdout. Use --output to specify output path.")
    ds.print()
    ds.sink_to(pulsar_sink)
    # submit for execution
    env.execute()


if __name__ == '__main__':
    main()
