import json
import logging

from pythonjsonlogger import jsonlogger

def get_logger(log_level):
    logger = logging.getLogger(__name__)
    logger.setLevel(log_level)
    logHandler = logging.StreamHandler()
    formatter = jsonlogger.JsonFormatter(
        fmt='%(asctime)s | %(levelname)s | %(name)s | %(message)s'
    )
    logHandler.setFormatter(formatter)
    logger.addHandler(logHandler)
    return logger

def read_json(filename):
    with open(filename) as f:
        return json.load(f)

def write_file(filename, data):
    f = open(filename, "w")
    f.write(data)
    f.close()