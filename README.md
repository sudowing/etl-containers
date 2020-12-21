#### General Implementation Pattern
# ETL Basics

This repo holds the source for multiple generic Docker images that can be used for Extract, Transform & Load Tasks.

Extract & Load tasks rely on the same set of images -- `base_001` and greater.

Transform Tasks rely on a single image -- `base_000`

These Images are designed to be used as the base images for more specific ETL tasks. They pre-package sets of dependencies, and standardize operating patterns across tasks.

Some of the key patterns are outlined below.

## Startup Script

Each Image runs a standard bash script at startup

> `/etl/src/etl.process.sh`

The design for this system is to overwrite this file and mount something task specific -- along with any relevant dependencies (SQL, json, requirements.txt, python scripts, etc...).

## Dumb I/O

These processes are designed to read and write from child directories.

> `/etl/src/input/`  
> `/etl/src/output/`

This approach simplifies development, as it is trivial to mount other volumes onto these locations at runtime -- which the application need not consider.

# Logging Standards

Each Image is preconfigured to write to **STOUT** in json strings, which are easily consumed by ELK, DataDog, Cloudwatch and the like.

This functionality is provided via an altered version of an interesting project called [bashlog](https://github.com/Zordrak/bashlog).

The relevant `ENV_VARS` are set in each respective `Dockerfile`, which can be redefined at runtime for development (as the none JSON output is colful and easier to read for [most] humans):
```sh
export BASHLOG_JSON=1
export BASHLOG_JSON_PATH='app_json.log'
export BASHLOG_JSON_STOUT=1

# disable json STOUT formatting
BASHLOG_JSON_STOUT=0
```


# Base Image Preperation

## Build Base Images
```sh
REPOS=(
    base_000_transform
    base_001_postgres
    base_002_mssql
    base_003_filesystem
    base_004_sftp
    base_005_aws_sdk
    base_006_http
    base_007_mongo
    base_008_snowflake
)
for REPO in "${REPOS[@]}"
do
   : 
   echo $REPO;
   cd $REPO \
       && docker build -t $REPO:develop -f ./Dockerfile . \
       && docker tag $REPO:develop $REPO:latest \
       && cd ..
done
```

## List Images
```sh
docker images
```

## Test Images
```sh
# base_000_transform
docker run base_000_transform:develop

# base_001_postgres
docker run base_001_postgres:develop

# base_002_mssql
docker run base_002_mssql:develop

# base_003_filesystem
docker run base_003_filesystem:develop

# base_004_sftp
docker run base_004_sftp:develop

# base_005_aws_sdk
docker run base_005_aws_sdk:develop

# base_006_http
docker run base_006_http:develop

# base_007_mongo
docker run base_007_mongo:develop

# base_008_snowflake
docker run base_008_snowflake:develop
```