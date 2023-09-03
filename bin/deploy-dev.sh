#!/bin/sh
# @Author: Sanjil Shrestha
# @Date:   2019-10-02 17:29:31
# @Last Modified by:   Sanjil Shrestha
# @Last Modified time: 2019-10-02 17:29:31

# set -e
START=$(date +%s)
DATE=$(date "+%Y%m%dT%H%M%S")

GR="\033[0;32m"
RD="\033[0;31m"
CY="\033[0;36m"
WT="\033[1;37m"
NC='\033[0m' # No Color

clear
echo "${CY}"
echo "   ____             _             _                  "
echo "  |  _ \  ___ _ __ | | ___  _   _(_)_ __   __ _      "
echo "  | | | |/ _ \ '_ \| |/ _ \| | | | | '_ \ / _\` |    "
echo "  | |_| |  __/ |_) | | (_) | |_| | | | | | (_| |     "
echo "  |____/ \___| .__/|_|\___/ \__, |_|_| |_|\__, |     "
echo "             |_|            |___/         |___/      "
echo "${NC}"

source .env
CWD=$WORKSPACE

finish() {

  END=$(date +%s)
  DIFF=$(($END - $START))

  echo ""
  echo "${GR}Built in $DIFF seconds${NC}"

  echo "${WT}"
  printf ".%.0s" {1..80}
  echo ""
  echo "The site can be tested at:"
  echo "      $SERVER"
  echo ""
  printf ".%.0s" {1..80}
  echo "${NC}"

}

prebuild() {
  cd $WORKSPACE/public/web/modules/
  if [ ! -f $WORKSPACE/public/web/modules/custom/README.md ] ; then
    rm -rf $WORKSPACE/public/web/modules/custom
    git clone git@bitbucket.org:thinkbluedata/drupal-custom-modules.git custom
  fi

  cd $WORKSPACE/public/web/modules/custom/
  git pull origin master

  cd $WORKSPACE/node/webcomponents/
  git pull origin master
  yarn install
  git checkout yarn.lock

  cd $WORKSPACE/
  docker exec -it "$PROJECT_NAME"_php /usr/local/bin/composer install

  cd $WORKSPACE/public/web/themes/custom/tbdtheme/
  yarn install
  git checkout yarn.lock

  cd $WORKSPACE/node/app/
  yarn install
  git checkout yarn.lock
}

buildAll() {
  cd $WORKSPACE/public/web/themes/custom/tbdtheme/
  yarn build

  cd $WORKSPACE/node/app/
  yarn build

  cd $WORKSPACE
  docker exec -it "$PROJECT_NAME"_php /usr/local/bin/composer install
  docker exec -it "$PROJECT_NAME"_php /usr/sbin/drush cim -y
  docker exec -it "$PROJECT_NAME"_php /usr/sbin/drush updb -y
  docker exec -it "$PROJECT_NAME"_php /usr/sbin/drush cr
}

rebuildDocker() {
  docker-compose down
  docker-compose up -d --build 
}

prebuild
buildAll
# rebuildDocker
finish
