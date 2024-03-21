from pulsar import Function
import json
import time


def mongo_source(func):
    def wrapper(*args, **kwargs):
        modified_args = list(args)
        if len(modified_args) > 1:
            # Modify incoming input data here
            modified_args[1] = (modified_args[1])
        result = func(*modified_args, **kwargs)
        return result

    return wrapper


class ExampleFunction(Function):
    def __init__(self):
        self.sink_topic = "persistent://public/default/mongo-sink"
        self.flink_topic = "persistent://public/default/flink-process"

    @staticmethod
    def is_insert(item):
        return 'operation' in item and item['operation'] == 'INSERT'

    @staticmethod
    def is_update(item):
        return 'operation' in item and item['operation'] == 'UPDATE'

    @mongo_source
    def process(self, input, context):
        logger = context.get_logger()
        data = json.loads(input)
        logger.info("\nMessage: {0}".format(data))
        # Setup instance configs
        if "output-topic" in context.get_user_config_map():
            self.sink_topic = context.get_user_config_value("output-topic")
        if "flink-topic" in context.get_user_config_map():
            self.flink_topic = context.get_user_config_value("flink-topic")
        msg_conf = {"properties": {k: v for d in [{"input_topic": context.get_current_message_topic_name()}, context.get_message_properties()] for k, v in d.items()},
                    "partition_key": context.get_partition_key(),
                    "event_timestamp": int(time.time())}
        # Output topic router
        if self.is_insert(data):
            context.publish(self.sink_topic, input, msg_conf)
        elif self.is_update(data):
            context.publish(self.flink_topic, input, msg_conf)
        else:
            logger.warn("The item {0} is neither an insert nor an update".format(input))
        return
