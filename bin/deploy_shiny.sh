#!/bin/sh
# @Author: Sanjil Shrestha
# @Date:   2022-02-25 17:29:31
# @Last Modified by:   Sanjil Shrestha
# @Last Modified time: 2022-02-25 17:29:31

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
MCORE=9

finish() {

  END=$(date +%s)
  DIFF=$(($END - $START))

  echo ""
  echo "${GR}Built in $DIFF seconds${NC}"
}

prebuild() {
  # Save current state
  cd $CWD

  # Pull latest code
  git checkout master
  git pull origin master
}

buildShiny() {
  cd $CWD/shiny

  /usr/bin/docker container stop myshiny
  /usr/bin/docker rm myshiny
  /usr/bin/docker build -t tbd/shiny .
  /usr/bin/docker run -p 8000:80 --name myshiny -d tbd/shiny
}

buildPlumber() {
  cd $CWD/shiny

  /usr/bin/docker container stop myplumber
  /usr/bin/docker rm myplumber

  c=$MCORE
  until [ ! $c -gt 0 ]; do
    n=$(printf "%02d" $c)
    echo "Stopping Containers myplumber$n"
    /usr/bin/docker container stop myplumber$n
    /usr/bin/docker rm myplumber$n
    c=$(expr $c - 1)
  done

  /usr/bin/docker build -t tbd/plumber -f Dockerfile-Plumber .
  /usr/bin/docker run -p 8800:8000 --name myplumber -v /opt/data/cache_data:/api/cache_data -d tbd/plumber

  c=$MCORE
  until [ ! $c -gt 0 ]; do
    n=$(printf "%02d" $c)
    echo "Starting Containers myplumber$n"
    /usr/bin/docker run -p 88$n:8000 --name myplumber$n -v /opt/data/cache_data:/api/cache_data -d tbd/plumber
    c=$(expr $c - 1)
  done
}

prebuild
buildShiny
buildPlumber
finish
