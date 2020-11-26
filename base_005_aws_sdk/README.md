# ETL Base 005 AWS SDK

This image provides generic functionality that is to be built upon.

Applications implementing this image have access to:
- aws sdk

# Docker Image Development & Publication

## Build
```sh
docker build -t base_005_aws_sdk:develop -f ./Dockerfile .
```
## Run
```sh
docker run -it base_005_aws_sdk:develop
```

## Release
```sh
docker tag \
	base_005_aws_sdk:develop \
	base_005_aws_sdk:master

docker tag \
	base_005_aws_sdk:develop \
	base_005_aws_sdk:latest
```

## Publish
```sh
docker push base_005_aws_sdk:master
docker push base_005_aws_sdk:latest
```

