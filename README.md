# laravelapache-docker
This project is for creating docker image to run laravel project, it has following features
* It is based on Ubuntu 16.0.4 image
* It allows SSH connection to server
* It has apache and PHP 7
* It include MySQL 5.6
* It maps working directory to docker image so changes in code will be instantly reflected in browser
* It creates new laravel project if it doesn't exists already
* It runs "composer install" to install dependency packages 
* It also install node dependencies
* It runs migration to create database

## Steps to use
* Pull this project in your working directory
* If you already have laravel project, copy content of your laravel project to "project" folder. After copying, structure of project folder should look like
 ```
 project
  |--app
  |--bootstrap
  |--config
  |--database
  |--...
  |--...
  |--.env
  |--composer.json
  |--...
  ```
* Open terminal and CD to "laravelapache-docker" folder or root of this project
* Run following command to build a docker image, note that "laravelapache" in image name used in docker-compose.yaml
 ```
   docker build -t laravelapache .
 ```
* Run following command to initialize a docker swarm with your system and master node
 ```
   docker swarm init
 ```
* Now run following command to deploy services defined on docker-composer.yaml file
 ```
   docker stack deploy -c docker-compose.yaml laravel
 ```
* The above command will run the services defined in docker-composer.yaml. For first time it may take up to an hour initialize the project and install the dependencies. To see the terminal output of whats happening run following command which will show terminal output of "laravel_web" service in docker
 ```
   docker service logs --follow laravel_web
 ```


## SSH connect inside laravel_web service
* Make sure docker container is running
* CD to "laravelapache-docker" folder or root of this project
* Now you can ssh-into the running container with following command
      
      ssh -p 2222 -i id_rsa root@localhost
      
## Stop and restart services
* To stop run 
```
   docker stack rm laravel
```
* To run the services again run following command, no need to build docker image again
```
   docker stack deploy -c docker-compose.yaml laravel
 ```
