# ETL Base 001 PostgreSQL

This image provides generic functionality that is to be built upon.

Applications implementing this image have access to:
- psql

# Docker Image Development & Publication

## Build
```sh
docker build -t base_001_postgresq:develop -f ./Dockerfile .
```
## Run
```sh
docker run -it base_001_postgresq:develop
```

## Release
```sh
docker tag \
	base_001_postgresq:develop \
	base_001_postgresq:master

docker tag \
	base_001_postgresq:develop \
	base_001_postgresq:latest
```

## Publish
```sh
docker push base_001_postgresq:master
docker push base_001_postgresq:latest
```

