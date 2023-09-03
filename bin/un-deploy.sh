#!/bin/sh
# @Author: Sanjil Shrestha
# @Date:   2019-06-05 15:48:45
# @Last Modified by:   Sanjil Shrestha
# @Last Modified time: 2022-09-20 10:58:39

## EDIT THESE VARIABLES PER PROJECT

SRC=$(pwd)
TBDGIT=docker-spp
UNGIT=un-spp
DES=$SRC/../$UNGIT
BACKUPTIME=T013501

## END OF EDIT

set -e
START=$(date +%s)

GR="\033[0;32m"
RD="\033[0;31m"
CY="\033[0;36m"
WT="\033[1;37m"
NC='\033[0m' # No Color

clear
source .env

echo "\n\n\n"

finish() {

	END=$(date +%s)
	DIFF=$(($END - $START))

	echo ""
	echo "${GR}Task took: $DIFF seconds${NC}"
}

echo "${CY}SYNC DRUPAL .....................(1)${NC}"

cp $SRC/.gitignore $DES/
mkdir -p $DES/public
mkdir -p $DES/installations/files
rsync -am --delete \
	--exclude="installations" --exclude=".git" \
	--exclude="private" --exclude="files" \
	--exclude="vendor" \
	--exclude="mock" --exclude="myadmin" --exclude="grunt" \
	--exclude=node_modules --exclude=*.lock \
	--exclude=gulpfile.js --exclude=firebase* \
	--exclude="scss" --exclude=".sass-cache" \
	--exclude="*.settings.php" --exclude="settings.php" \
	--exclude="services.yml" \
	$SRC/public/ $DES/public/

echo "${CY}SYNC FILES ......................(2)${NC}"
rsync -am --delete \
	--exclude="php" --exclude="*js*" \
	--exclude="*css*" \
	--exclude="config_*" \
	--exclude="*cache*" \
	root@$SERVER:/opt/server/public/web/sites/default/files/ $DES/installations/files/

echo "${CY}SYNC MODULES ....................(3)${NC}"
xargs -I{} rm -rf $DES/public/web/modules/custom/{} < $SRC/bin/$UNGIT-excluded-modules.txt

echo "${CY}COPY DATABASE ...................(4)${NC}"

mkdir -p $DES/installations/initdb
scp root@$SERVER:/opt/backup/sql/daily/"$PROJECT_NAME"-"$(date +"%Y%m%d")"$BACKUPTIME.sql.gz $DES/installations/initdb/

echo "${CY}ADD COMMIT ......................(5)${NC}"
GITVER=$(git rev-parse --short HEAD)
cd $DES
# git reset --hard HEAD
git add .
git commit -m "Commits from $TBDGIT version $GITVER"

cd $SRC
echo "${CY}PUSH YOUR COMMIT (Manually)......(6)${NC}"
