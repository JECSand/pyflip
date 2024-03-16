from pulsar import Function
import json

class ExampleFunction(Function):
    def __init__(self):
        pass

    def process(self, input, context):
        logger = context.get_logger()
        logger.info("Message Content: {0}".format(input))
        arr = json.loads(input)
        logger.info("Message Content Data: {0}".format(arr))
        message_doc = arr.get("fullDocument")
        logger.info("Message Doc Data: {0}".format(message_doc))
        # arr['content']['fullDocument']['length'] += 55
        return json.dumps(message_doc)
