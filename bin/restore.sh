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

FILE=$1
## Drop old database
echo "SET FOREIGN_KEY_CHECKS = 0;" > db/backup/drop.sql
docker exec "$PROJECT_NAME"_db sh -c "mysqldump -uroot -p$MYSQL_ROOT_PASSWORD --add-drop-table --no-data $MYSQL_DATABASE | grep ^DROP " >> db/backup/drop.sql
echo "SET FOREIGN_KEY_CHECKS = 1;" >> db/backup/drop.sql

docker exec "$PROJECT_NAME"_db sh -c \
  "mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /var/lib/backup/drop.sql"

rm db/backup/drop.sql

## Insert new database

docker exec "$PROJECT_NAME"_db sh -c \
  "mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /var/lib/backup/$FILE"

echo "Restoring up data completed."

finish
