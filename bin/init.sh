#!/bin/sh
# @Author: Sanjil Shrestha
# @Date:   2019-06-05 15:48:45
# @Last Modified by:   Sanjil Shrestha
# @Last Modified time: 2019-09-20 13:51:59

# set -e
START=$(date +%s)

GR="\033[0;32m"
RD="\033[0;31m"
CY="\033[0;36m"
WT="\033[1;37m"
NC='\033[0m' # No Color

sudo clear
CWD=$(pwd)
echo "${CY}Load from environment .......................(1)${NC}"
s="WORKSPACE=$CWD"; grep -Fxqe "$s" < .env || printf "%s\n" "$s" >> .env
source .env
git checkout master
git pull origin master

finish() {

  END=$(date +%s)
  DIFF=$(($END - $START))

  echo ""
  echo "${GR}Task took: $DIFF seconds${NC}"
}

echo "${CY}Restoring Database ..........................(2)${NC}"
cp $CWD/db/initdb/*.sql $CWD/db/backup/

## Drop old database
echo "SET FOREIGN_KEY_CHECKS = 0;" > db/backup/drop.sql
docker exec "$PROJECT_NAME"_db sh -c "mysqldump -uroot -p$MYSQL_ROOT_PASSWORD --add-drop-table --no-data $MYSQL_DATABASE | grep ^DROP " >> db/backup/drop.sql
echo "SET FOREIGN_KEY_CHECKS = 1;" >> db/backup/drop.sql

docker exec "$PROJECT_NAME"_db sh -c \
  "mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /var/lib/backup/drop.sql"

rm $CWD/db/backup/drop.sql

## Insert new database

docker exec "$PROJECT_NAME"_db sh -c \
  "mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /var/lib/backup/initdb.sql"

echo "${CY}Composer Install ............................(3)${NC}"

docker exec -ti "$PROJECT_NAME"_php /bin/sh -c \
  "rm composer.lock && php -d memory_limit=-1 /usr/local/bin/composer install"

echo "${CY}Checkout Custom Modules .....................(4)${NC}"

cd $CWD/public/web/modules/
rm -rf $CWD/public/web/modules/custom
git clone git@bitbucket.org:thinkbluedata/drupal-custom-modules.git custom
cd $CWD

cd $CWD/node/
rm -rf $CWD/node/webcomponents
git clone git@bitbucket.org:thinkbluedata/webcomponents.git webcomponents
cd webcomponents
yarn install
cd $CWD

echo "${CY}Setting up the Settings File ................(5)${NC}"
chmod u+w $CWD/public/web/sites/default/
sudo rm $CWD/public/web/sites/default/settings.php
cp $CWD/public/web/sites/default/local.settings.php $CWD/public/web/sites/default/settings.php
sudo chmod 444 $CWD/public/web/sites/default/settings.php

echo "${CY}Clean up with Drush Install .................(6)${NC}"

docker exec -ti "$PROJECT_NAME"_php /bin/sh -c \
  "drush cim -y && drush updb -y && drush cr"

finish
