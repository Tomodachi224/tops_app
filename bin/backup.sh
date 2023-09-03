#!/bin/sh
# @Author: Sanjil Shrestha
# @Date:   2019-06-05 15:48:45
# @Last Modified by:   Sanjil Shrestha
# @Last Modified time: 2019-09-20 13:51:59

set -e
START=$(date +%s)

GR="\033[0;32m"
RD="\033[0;31m"
CY="\033[0;36m"
WT="\033[1;37m"
NC='\033[0m' # No Color

source .env

finish() {

  END=$(date +%s)
  DIFF=$(($END - $START))

  echo ""
  echo "${GR}Task took: $DIFF seconds${NC}"
}

NOW=$(date +"%m-%d-%Y_%H-%M")
FILE="backup-$NOW.sql"
docker exec "$PROJECT_NAME"_db sh -c \
  "mysqldump -h '$PROJECT_NAME'_db -u root -p$MYSQL_ROOT_PASSWORD \
    --databases $MYSQL_DATABASE > /var/lib/backup/$FILE"
echo "Backing up data completed."

finish
