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

CWD=/Users/team/workspace/tbd/docker-spp/pshiny
MCORE=4

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
  git checkout dev
  git pull origin dev
}

buildShiny() {
  cd $CWD/shiny

  docker container stop myshiny
  docker rm myshiny
  docker build -t tbd/shiny .
  docker run -p 8000:80 --name myshiny -d tbd/shiny
}

buildPlumber() {
  cd $CWD/shiny

  docker container stop myplumber
  docker rm myplumber

  c=$MCORE
  until [ ! $c -gt 0 ]; do
    n=$(printf "%02d" $c)
    echo "Stopping Containers myplumber$n"
    docker container stop myplumber$n
    docker rm myplumber$n
    c=$(expr $c - 1)
  done

  docker build -t tbd/plumber -f Dockerfile-Plumber .
  docker run -p 8800:8000 --name myplumber -v /opt/data/cache_data:/api/cache_data -d tbd/plumber

  c=$MCORE
  until [ ! $c -gt 0 ]; do
    n=$(printf "%02d" $c)
    echo "Starting Containers myplumber$n"
    docker run -p 88$n:8000 --name myplumber$n -v /opt/data/cache_data:/api/cache_data -d tbd/plumber
    c=$(expr $c - 1)
  done
}

prebuild
# buildShiny
buildPlumber
finish
