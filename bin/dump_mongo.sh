#!/bin/sh
# @Author: Sanjil Shrestha
# @Date:   2021-05-28 19:18:03
# @Last Modified by:   Sanjil Shrestha
# @Last Modified time: 2021-05-28 19:18:03

source .env

CONTAINER_NAME="${PROJECT_NAME}_mongo" 

docker exec $CONTAINER_NAME sh -c "mongodump --db=${PROJECT_NAME}db  \
 --authenticationDatabase admin --username=${MONGO_INITDB_ROOT_USERNAME} --password=${MONGO_INITDB_ROOT_PASSWORD} \
 -o /opt/server/mongo/initdb/"

docker cp "${CONTAINER_NAME}:/opt/server/mongo/initdb/${PROJECT_NAME}db" ./mongo/initdb/

echo "All data are dumped into mongo/initdb/${PROJECT_NAME}db ."
