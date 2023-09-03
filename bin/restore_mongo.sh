#!/bin/sh
# @Author: Anawat Onmee
# @Date:   2020-05-11:11:14
# @Last Modified by:   Anawat Onmee
# @Last Modified time: 2020-05-11:11:14

source .env

CONTAINER_NAME="${PROJECT_NAME}_mongo" 

# docker cp ./mongo/initdb/${PROJECT_NAME}db "${CONTAINER_NAME}:/tmp/mongoinit/" 

docker exec "${PROJECT_NAME}_mongo" sh -c "mongorestore \
 --db ${PROJECT_NAME}db \
 --authenticationDatabase admin --username=${MONGO_INITDB_ROOT_USERNAME} --password=${MONGO_INITDB_ROOT_PASSWORD} \
 --drop /opt/server/mongo/initdb/${PROJECT_NAME}db"

# add this to above command while running on server
#  --db ${PROJECT_NAME}db \


# docker cp ./mongo/initdb/data.json "${CONTAINER_NAME}:/tmp/data.json"
# docker exec $CONTAINER_NAME sh -c "mongoimport --db=idddb --collection=idddata \
#   --authenticationDatabase admin --username=${MONGO_INITDB_ROOT_USERNAME} --password=${MONGO_INITDB_ROOT_PASSWORD} \
#   --drop --jsonArray \"/tmp/data.json\""

echo "Restoring up data completed."
