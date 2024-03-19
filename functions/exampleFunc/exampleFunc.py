from pulsar import Function
import json


def mongo_source(func):
    def wrapper(*args, **kwargs):
        modified_args = list(args)
        if len(modified_args) > 1:
            replaces = [
                ['key:[', "\"key\":["],
                [' properties:[', " \"properties\":["],
                ['content:{"', "\"content\":{\""]
            ]
            modified_args[1] = (modified_args[1]
                                .replace(replaces[0][0], replaces[0][1])
                                .replace(replaces[1][0], replaces[1][1])
                                .replace(replaces[2][0], replaces[2][1]))
        result = func(*modified_args, **kwargs)
        return result

    return wrapper


class ExampleFunction(Function):
    def __init__(self):
        pass

    @mongo_source
    def process(self, input, context):
        logger = context.get_logger()
        data = json.loads(input)
        logger.info("\nMessage: {0}".format(data))
        # logger.info("Content: {0}".format(data.get("content")))
        return json.dumps(data)
