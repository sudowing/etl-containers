# ETL Base 002 MSSQL [sqlcmd]

This image provides generic functionality that is to be built upon.

Applications implementing this image have access to:
- sqlcmd

# Docker Image Development & Publication

## Build
```sh
docker build -t base_002_mssql:develop -f ./Dockerfile .
```
## Run
```sh
docker run -it base_002_mssql:develop
```

## Release
```sh
docker tag \
	base_002_mssql:develop \
	base_002_mssql:master

docker tag \
	base_002_mssql:develop \
	base_002_mssql:latest
```

## Publish
```sh
docker push base_002_mssql:master
docker push base_002_mssql:latest
```

