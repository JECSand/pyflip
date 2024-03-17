from pulsar import Function
import json


def format_mongo(func):
    def wrapper(*args, **kwargs):
        # Modify the input parameter
        modified_args = list(args)
        if len(modified_args) > 0:

            modified_args[0] = f"Modified: {modified_args[0]}"
        # Call the original function with the modified input
        result = func(*modified_args, **kwargs)
        return result

    return wrapper

class ExampleFunction(Function):
    def __init__(self):
        pass

    def process(self, input, context):
        logger = context.get_logger()

        logger.info("Message: {0}".format(input))
        logger.info("Content: {0}".format(input.content))
        return input
