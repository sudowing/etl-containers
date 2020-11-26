# ETL Base 006 HTTP

This image provides generic functionality that is to be built upon.

Applications implementing this image have access to:
- python3
- [requests](https://requests.readthedocs.io/en/master/) (python lib)

# Docker Image Development & Publication

## Build
```sh
docker build -t base_006_http:develop -f ./Dockerfile .
```
## Run
```sh
docker run -it base_006_http:develop
```

## Release
```sh
docker tag \
	base_006_http:develop \
	base_006_http:master

docker tag \
	base_006_http:develop \
	base_006_http:latest
```

## Publish
```sh
docker push base_006_http:master
docker push base_006_http:latest
```

