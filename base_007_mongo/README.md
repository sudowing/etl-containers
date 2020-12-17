# ETL Base 007 Mongo

This image provides generic functionality that is to be built upon.

Applications implementing this image have access to:

- bsondump - display BSON files in a human-readable format
- mongoimport - Convert data from JSON, TSV or CSV and insert them into a collection
- mongoexport - Write an existing collection to CSV or JSON format
- mongodump/mongorestore - Dump MongoDB backups to disk in .BSON format, or restore them to a live database
- mongostat - Monitor live MongoDB servers, replica sets, or sharded clusters
- mongofiles - Read, write, delete, or update files in GridFS
- mongotop - Monitor read/write activity on a mongo server

# Docker Image Development & Publication

## Build
```sh
docker build -t base_007_mongo:develop -f ./Dockerfile .
```
## Run
```sh
docker run -it base_007_mongo:develop
```

## Release
```sh
docker tag \
	base_007_mongo:develop \
	base_007_mongo:master

docker tag \
	base_007_mongo:develop \
	base_007_mongo:latest
```

## Publish
```sh
docker push base_007_mongo:master
docker push base_007_mongo:latest
```

