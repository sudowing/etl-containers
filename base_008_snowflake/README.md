# ETL Base 008 Snowflake

This image provides generic functionality that is to be built upon.

Applications implementing this image have access to:
- snowsql

# Docker Image Development & Publication

## Build
```sh
docker build -t base_008_snowflake:develop -f ./Dockerfile .
```
## Run
```sh
docker run -it base_008_snowflake:develop
```

## Release
```sh
docker tag \
	base_008_snowflake:develop \
	base_008_snowflake:masterls

docker tag \
	base_008_snowflake:develop \
	base_008_snowflake:latest
```

## Publish
```sh
docker push base_008_snowflake:master
docker push base_008_snowflake:latest
```



https://coolaj86.com/articles/using-snowsql-with-docker/
