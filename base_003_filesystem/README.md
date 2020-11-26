# ETL Base 003 Filesystem

This image provides generic functionality that is to be built upon.

Applications implementing this image have access to:
- bash

# Docker Image Development & Publication

## Build
```sh
docker build -t base_003_filesystem:develop -f ./Dockerfile .
```

## Run
```sh
docker run -it base_003_filesystem:develop
```

## Release
```sh
docker tag \
	base_003_filesystem:develop \
	base_003_filesystem:master

docker tag \
	base_003_filesystem:develop \
	base_003_filesystem:latest
```

## Publish
```sh
docker push base_003_filesystem:master
docker push base_003_filesystem:latest
```