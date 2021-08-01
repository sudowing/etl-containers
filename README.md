#### General Implementation Pattern

# ETL Pattern Overview

This repo holds the source for multiple generic Docker images that can be used for Extract, Transform & Load Tasks.

Extract & Load tasks rely on the same set of images -- `base_001` and greater.

Transform Tasks rely on a single image -- `base_000`

These Images are designed to be used as the base images for more specific ETL tasks. They pre-package sets of dependencies, and standardize operating patterns across tasks.

Some of the key patterns are outlined below.

#  <a id="table-of-contents"></a>Table of Contents

 * [Conceptual Description](#conceptual_description)
    * [Dumb I/O](#dumb_i_o)
    * [Startup Script](#startup_script)
    * [`meta.json` files](#meta_json_files)
    * [Logging Standards](#logging_standards)
 * [Role of Docker Volumes](#role_of_docker_volumes)
    * [Install the REX-Ray Plugin](#install_the_rex_ray_plugin)
    * [Create Docker Volumes with REX-Ray](#create_docker_volumes_with_rex_ray)
    * [Tips](#tips)
 * [Base Image Preperation](#base_image_preperation)
    * [Build Base Images](#build_base_images)
    * [List Images](#list_images)
    * [Test Images](#test_images)


# <a id="conceptual_description"></a> Conceptual Description

```
# implementation of base > #000 container
extract(config, output_dir)
    read: network resource
    write: disk (output_dir)

# implementation of base #000_transform container
transform(config, input_dir, output_dir)
    read: disk (input_dir)
    write: disk (output_dir)

# implementation of base > #000 container
load(config, input_dir)
    read: disk (input_dir)
    write: network resource
```

## <a id="dumb_i_o"></a> Dumb I/O

These processes are designed to read and write from child directories.

> `/etl/src/input/`  
> `/etl/src/output/`

This approach simplifies development, as it is trivial to mount other volumes onto these locations at runtime -- which the application need not consider.

## <a id="startup_script"></a> Startup Script

Each Image runs a standard bash script at startup

> `/etl/src/etl.process.sh`

The design for this system is to overwrite this file and mount something task specific -- along with any relevant dependencies (SQL, json, requirements.txt, python scripts, etc...).

## <a id="meta_json_files"></a> `meta.json` files

Each base container's repo contains a json file named `meta.json`. The purpose of this file is to provide an artifact to use by a CI/CD worker to use to correctly build & tag releases and images.

## <a id="logging_standards"></a> Logging Standards

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

# <a id="role_of_docker_volumes"></a> Role of Docker Volumes

The apps utilize dumb I/O -- reading & writing only to child input/output directories. When deployed, can mount a Docker Volume (backed by an AWS S3 bucket) onto either the `input` and/or `output` locations.

While there are probably many methods for accomplishing this, I rely on on [REX-Ray Docker Plugin](https://rexray.readthedocs.io/en/v0.9.0/user-guide/docker-plugins/).

## <a id="install_the_rex_ray_plugin"></a> Install the REX-Ray Plugin

```
docker plugin install rexray/s3fs S3FS_ACCESSKEY=ABC S3FS_SECRETKEY=XYZ
```

## <a id="create_docker_volumes_with_rex_ray"></a> Create Docker Volumes with REX-Ray
```
docker volume create --driver rexray/s3fs vlm0001-current
docker volume create --driver rexray/s3fs vlm0001-archive
```

## <a id="tips"></a> Tips

Be sure to lock down the S3 bucket settings so that it is not readable from the public internet.

# <a id="base_image_preperation"></a> Base Image Preperation

## <a id="build_base_images"></a> Build Base Images
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
    base_009_redshift
)
for REPO in "${REPOS[@]}"
do
   echo $REPO;
   cd $REPO \
       && docker build -t $REPO:develop -f ./Dockerfile . \
       && docker tag $REPO:develop $REPO:latest \
       && cd ..
done
```

## <a id="list_images"></a> List Images
```sh
docker images
```

## <a id="test_images"></a> Test Images

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

# base_009_redshift
docker run base_009_redshift:develop
```
