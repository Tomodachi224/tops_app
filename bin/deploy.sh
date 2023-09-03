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

CWD=/opt/server

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
  # Save current state
  cd $CWD/public
  drush cex -y

  # Archvie folder
  mkdir -p /root/archive/
  cd /root/archive/
  tar -zcvf config-$DATE.tar.gz $CWD/public/config/

  # Keep the number of files in check
  ls -1t | tail -n +52 | xargs rm -f

  # Fetch new changes
  cd $CWD/public/

  rm -rf $CWD/public/config/sync
  git checkout $CWD/public/config/sync
  git checkout $CWD/public/composer.*

  # Pull latest code
  git checkout master
  git pull origin master

  # Pull for submodules
  cd $CWD/public/web/modules/custom/
  git pull origin master
  cd $CWD/
}

buildDrupal() {
  cd $CWD/
  export COMPOSER_ALLOW_SUPERUSER=1;

  # Apply patch
  # git apply patch/search_api_server.patch

  cd $CWD/public
  composer install
  drush cim -y
  drush updb -y
  drush cr
}

buildApp() {
  cd $CWD/node/app
  yarn install
  # yarn build # Moved to CI
}

buildWC() {
  # Pull for submodules
  cd $CWD/node/webcomponents
  git pull origin master
  yarn install
  git checkout yarn.lock
}

buildRAPIs() {
  cd $CWD/node/rapis
  yarn install
  git checkout yarn.lock
  pm2 startOrRestart ecosystem.config.js --env production
}

buildTheme(){
  cd $CWD/public/web/themes/custom/tbdtheme/
  yarn install
  # yarn build # Moved to CI
}

buildPython() {
  systemctl daemon-reload
  # systemctl stop tbdproject
  # systemctl start tbdproject
}

prebuild
buildDrupal
# buildWC
# buildApp
buildRAPIs
buildTheme
# buildPython
finish
