import json

data = """{"key":[{"_id": {"$oid": "65f62d575d19b6888c7a48ad"}}], "properties":[], "content":{"fullDocument":{"_id":{"timestamp":1710632279,"date":1710632279000},"breadth":0,"country_name":"Panama","country_code":"PA","call_sign":"3FEI5","cargo":"Cargo","draught":7,"imo":9660607,"length":111,"name":"MEDI MANILA","mmsi":353664000},"ns":{"databaseName":"geoglify","collectionName":"ships","fullName":"geoglify.ships"},"operation":"INSERT"}}"""

print(data)


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

class ExampleFunction():
    def __init__(self):
        pass

    def process(self, input, context):
        logger = context.get_logger()
        logger.info("Message: {0}".format(input))
        logger.info("Content: {0}".format(input.content))
        return input

print(json.loads(data))