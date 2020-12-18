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

