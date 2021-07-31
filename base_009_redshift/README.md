# ETL Base 009 Redshift

This image provides generic functionality that is to be built upon.

Applications implementing this image have access to:
- psql
- aws sdk

# Docker Image Development & Publication

## Build
```sh
docker build -t base_009_redshift:develop -f ./Dockerfile .
```
## Run
```sh
docker run -it base_009_redshift:develop
```

## Release
```sh
docker tag \
	base_009_redshift:develop \
	base_009_redshift:latest
```

## Publish
```sh
docker push base_009_redshift:latest
```

