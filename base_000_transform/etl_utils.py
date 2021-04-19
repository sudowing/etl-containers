import json
import logging
from math import floor
import time

from basket_case import slug
from pandas import DataFrame, notnull
from pythonjsonlogger import jsonlogger

# convenience fns
change_case = lambda s: slug(s).replace('-', '_')
Map = lambda fun, iter: list(map(fun, iter))
mb_to_bytes = lambda mb: mb * 1048576

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

def gen_df_transformer(col_transformers, row_transformers):
    def curried_serializer(df):
        for column, fn in col_transformers.items():
            df[column] = df[column].map(fn)

        for column, fn in row_transformers.items():
            df[column] = df.apply(fn, 1)

        df = df.reindex(columns=sorted(df.columns))
        return df
    return curried_serializer

def generic_json_to_csv_transformer(logger, target_mem_size, files, specs, timestamp = time.time()):
    serializer = gen_df_transformer(specs.col_transformers, specs.row_transformers)

    for filename in sorted(files):
        log_base = { 'file': filename ,'timestamp': timestamp }
        logger.info('[START] processing {}'.format(filename), extra=log_base)

        try:
            source = read_json(filename)
            if(specs.records_exist(source)):
                df = DataFrame.from_records(specs.records_list(source), index=None)

                # change column case and reorder
                df.columns = Map(change_case, df.columns)

                # validate fields present
                # df.columns

                # calculate metrics for optimal batch size (based on MBs)
                mem_size_total = df.memory_usage(deep=True).sum()
                count_total = len(df.index)
                # this could be better | https://stackoverflow.com/questions/18089667/how-to-estimate-how-much-memory-a-pandas-dataframe-will-need
                target_disk_size = mb_to_bytes(target_mem_size * 4)
                count_chunk = floor(count_total / floor(mem_size_total / target_disk_size))
                
                # chunk the batch into target sizes
                for i in range(0, count_total, count_chunk):
                    for record_chunk in [range(0,count_total)[i:i + count_chunk]]:
                        count_batch = len(record_chunk)
                        batch_meta = '{}.{}-{}'.format(str(target_mem_size),str(i),str(i + count_batch))
                        ## transforms could happen here to decrease total mem size
                        serializer(df[i:i + count_batch].copy()) \
                            .to_csv(
                                specs.gen_output_name(timestamp, filename, batch_meta),
                                index=False,
                                doublequote=False,# escapechar='\\'
                                quotechar='`',
                                escapechar='\\',
                                chunksize=count_chunk
                            )

                        logger.info('writing batch to disk', extra={
                            **log_base
                            ,'count_total': count_total
                            ,'count_chunk': count_chunk
                            ,'count_batch': count_batch
                            ,'batch_start_index': i
                        })

            logger.info('[COMPLETE] processing {}'.format(filename), extra=log_base)

        except Exception as e:
            logger.error('exception'.format(filename), extra={**log_base,'error':e})
