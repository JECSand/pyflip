from pulsar import Function
import json


def mongo_source(func):
    def wrapper(*args, **kwargs):
        modified_args = list(args)
        if len(modified_args) > 1:
            """
            replaces = [
                ['key:[', "\"key\":["],
                [' properties:[', " \"properties\":["],
                ['content:{"', "\"content\":{\""]
            ]
            modified_args[1] = (modified_args[1]
                                .replace(replaces[0][0], replaces[0][1])
                                .replace(replaces[1][0], replaces[1][1])
                                .replace(replaces[2][0], replaces[2][1]))
            """
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
        return 'operation' in item and item['operation'] == 'insert'

    @staticmethod
    def is_update(item):
        return 'operation' in item and item['operation'] == 'update'

    @mongo_source
    def process(self, input, context):
        logger = context.get_logger()
        data = json.loads(input)
        logger.info("\nMessage: {0}".format(data))
        # logger.info("Content: {0}".format(data.get("content")))
        if self.is_insert(data):
            context.publish(self.click_topic, input)
        elif self.is_update(data):
            context.publish(self.flink_topic, input)
        else:
            logger.warn("The item {0} is neither an insert nor an update".format(input))
        return json.dumps(data)
