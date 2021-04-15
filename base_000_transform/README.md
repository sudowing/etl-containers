# ETL Base 000 Transform

This image provides generic functionality that is to be built upon.

Applications implementing this image have access to:
- python3
- sqlite3
- jq
- unzip

# Docker Image Development & Publication

## Build
```sh
docker build -t base_000_transform:develop -f ./Dockerfile .
```
## Run
```sh
docker run -it base_000_transform:develop
```

## Release
```sh
docker tag \
	base_000_transform:develop \
	base_000_transform:latest
```

## Publish
```sh
docker push base_000_transform:latest
```

