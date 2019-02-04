# Docker Development Environment For Laravel (laravel-apache-docker)

**NOTE: This project is only suitable for development environment**

This project is for creating docker image to run laravel project, it has following features
* It is based on Ubuntu 16.0.4 image
* It allows SSH connection to docker container using private key (this is only for diagnostic purpose during development)
* It includes apache and PHP 7
* It includes MySQL 5.6 server
* It maps your working directory to docker image, so that changes in code will be instantly reflected in browser
* It creates new laravel project if it doesn't exists already
* It runs "composer install" to install dependency packages 
* It also install node dependencies if any
* It runs migration to create database

## Installing docker
If docker is not installed in your system, please follow the link below to install it
https://docs.docker.com/engine/installation/

## Steps to use
* git pull this project in your working directory
* Notice files "id_rsa" and "id_rsa.pub", they are private and public keys that will be used to do SSH connection to the container. "id_rsa.pub" will be copied to docker container and "id_rsa" will be used in your shell to do SSH connection. If you want to use your own key pair, you can replace it with your key pair before building docker image.
* Leave this step if you want to create new laravel project. If you already have laravel project, copy content of your laravel project to "project" folder. After copying, structure of project folder should look like
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
* Now setup the database configuration in ".env" file as follow. 
```
   hostname = database #Service name of mysql container in docker-compose.yaml
   username = homestead #See docker-compose.yaml
   password = secret #See docker-compose.yaml
 ```
* Open terminal (shell) and CD to "laravel-apache-docker" folder or root of this project
* Run following command to build a docker image, note that "laravelapache" is the image name used in docker-compose.yaml file
 ```
   docker build -t laravelapache .
 ```
* Now run following command to deploy services defined on docker-composer.yaml file
 ```
   docker-compose up
 ```
* The above command will run the services defined in "docker-composer.yaml". For first time it may take up to an hour to initialize the project, install the dependencies and run migrations. You can see progress in the terminal window.
* After necessary scripts are run you will see message saying "Apache server is running ..., browse your project using 'localhost'". Now you can browse your project using localhost.

## SSH connect inside laravel_web service
* Make sure docker container is running
* CD to "laravel-apache-docker" folder or root of this project
* Now you can ssh-into the running container with following command
```
   ssh -p 2222 -i id_rsa root@localhost
```
## Stop and restart services
* To stop running services press keys ctrl + C

* Run following command to unload the services
```
   docker-compose down
```


