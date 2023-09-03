# SPP Project Docker

Make sure to update the passwords in the .env

## Getting Started

### Clone the project

```
$ cd ~/workspace
$ git clone git@bitbucket.org:company/docker-spp.git
```

### Star the docker

```
cp .env.example .env
source .env
docker-compose up --build
```

### Init Project

At any point of time you can run the following to reset the project

```
./bin/init.sh
```

### How to build theme

```
cd $WORKSPACE/public/web/theme/custom/cmptheme
yarn install
yarn build
yarn serve
```

### How to build Shiny

Building the shiny app has two parts, one for the shiny app and the other for the plumber API.
The first part is build as follow:

```
cd $WORKSPACE/shiny

docker build -t cmp/shiny .
docker rm myshiny

docker run -p 80:80 --name myshiny cmp/shiny
```

The second part is build as follow:

```
cd $WORKSPACE/shiny

docker build -t cmp/plumber -f Dockerfile-Plumber .
docker rm myplumber

docker run -p 8000:8000  --name myplumber cmp/plumber
```

### How to deploy Shiny in server

Follow the instructions below to deploy the Shiny and Plumber API into the server

```
ssh root@shiny@company.com
cd /opt/server/shiny/
git pull origin master

# Rebuild Docker
docker container stop myshiny
docker rm myshiny
docker build -t cmp/shiny .
docker run -p 8000:80 --name myshiny -d cmp/shiny

# Rebuild the PLumber

docker container stop myplumber
docker rm myplumber
docker build -t cmp/plumber -f Dockerfile-Plumber .
docker run -p 8800:8000 --name myplumber -d cmp/plumber

# Verify
docker container ps
```

If we need to flush we can try these

```
docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker rmi cmp/shiny
```

## The Database

To access database open [http://localhost:8000/](http://localhost:8000/).

The username is in the .env file

### How to Run composers

To run `composer`, first get inside the docker container

```
source .env
docker exec -it "$PROJECT_NAME"_php /bin/sh
/var/www/html # composer install
```

### How to Run drush

To run `drush`, first get inside the docker container

```
source .env
docker exec -it "$PROJECT_NAME"_php /bin/sh
/var/www/html # drush cr
```

### How to Import and export configurations

```
source .env
docker exec -it "$PROJECT_NAME"_php /bin/sh
/var/www/html #
```

Import configuration

```
drush cim
```

Export configuration

```
drush cex
```

### How to take Backup

From the project home path

```
./bin/backup.sh
```

To backup database as .sql file

### How to Restore from backup

Restoring database (mysql)

```
./bin/restore.sh <backup_file_name>
```

### How to Rebuild permission

```
source .env
docker exec -it "$PROJECT_NAME"_php /bin/sh
/var/www/html # drush php-eval 'node_access_rebuild();'
```

### How to Save configuration changes from server

If you made changes to the server then don't forget to save it to git, else they will be replaced in the next deployment.
Change the env variables as needed

```
SERVER=spp.company.com
WORKSPACE=~/workspace/cmp/docker-spp
```

Run these commands on the server

```
ssh root@$SERVER
cd /opt/server/public/
drush cex -y
exit
```

Run these commands on your local computer

```
scp root@$SERVER:/opt/server/public/composer* $WORKSPACE/public/
rsync -avm --delete root@$SERVER:/opt/server/public/config/ $WORKSPACE/public/config/
```

### How to sync to UN git

- Make sure your env variables are set. If missing add `WORKSPACE=~/workspace/cmp/docker-spp` at the end of the `.env` file.
- Read `.env` file using `source` command. `$ source .env`
- Clone the cmp-UN git one level outside of the current folder. Eg: I have my project at `~/workspace/cmp/docker-spp` and the un git is located at `~/workspace/cmp/un-spp`. Please make necessary changes in the `un-deploy.sh` file.
- From the root folder run `bin ./un-deploy.sh`
- Open your git client and push the code if everything looks ok.

#### To remove custom module from UN git

- Prepare the list of excluded modules for your project in file bin/un-{project}-excluded-module.txt

## Troubleshoot

### Memory Limi

It is quite often to encounter memory limitation in docker for composer install/upgrade, in such case use the following command instead

```
php -d memory_limit=-1 /usr/local/bin/composer install
```

This will temporarily bypass the memory restriction without need to change into `php.ini`.

### Permission Issues

Sometime we may encounter permission issues inside `default` folder, in such case use the following command

```
chmod u+w $WORKSPACE/public/web/sites/default/
```

### Enter to MongoDB Shell and add new column, "pension_tested"

```
mongo --username mongoroot --password 32nkU0YsAbTnf
db.SppData.updateMany({}, {$set: {"pension_tested": false}})
```
