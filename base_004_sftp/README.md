# ETL Base 004 SFTP

This image provides generic functionality that is to be built upon.

Applications implementing this image have access to:
- sftp

# Docker Image Development & Publication

## Build
```sh
docker build -t base_004_sftp:develop -f ./Dockerfile .
```
## Run
```sh
docker run -it base_004_sftp:develop
```

## Release
```sh
docker tag \
	base_004_sftp:develop \
	base_004_sftp:master

docker tag \
	base_004_sftp:develop \
	base_004_sftp:latest
```

## Publish
```sh
docker push base_004_sftp:master
docker push base_004_sftp:latest
```

