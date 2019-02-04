# laravel-apache-docker

**NOTE: This project is only suitable for development environment**

This project is for creating docker image to run laravel project, it has following features
* It is based on Ubuntu 16.0.4 image
* It allows SSH connection to server using private key
* It includes apache and PHP 7
* It includes MySQL 5.6 server
* It maps working directory to docker image, so that changes in code will be instantly reflected in browser
* It creates new laravel project if it doesn't exists already
* It runs "composer install" to install dependency packages 
* It also install node dependencies if any
* It runs migration to create database

## Installing docker
If you docker is not installed in your system, following link below to install it
https://docs.docker.com/engine/installation/

## Steps to use
* Pull this project in your working directory
* Notice files "id_rsa" and "id_rsa.pub" there are private and public key used for SSH connection to server. "id_rsa.pub" will be copied to docker container and "id_rsa" will be used to do SSH connect. You can replace it with your key pair before building docker image to use your key pair.
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
* Now seup the database configuration in ".env" file following setting. 
```
   hostname = database #Service name of mysql container in docker-compose.yaml
   username = homestead #See docker-compose.yaml
   password = secret #See docker-compose.yaml
 ```
* Open terminal and CD to "laravelapache-docker" folder or root of this project
* Run following command to build a docker image, note that "laravelapache" in image name used in docker-compose.yaml file
 ```
   docker build -t laravelapache .
 ```
* Now run following command to deploy services defined on docker-composer.yaml file
 ```
   docker-compose up
 ```
* The above command will run the services defined in "docker-composer.yaml". For first time it may take up to an hour to initialize the project, install the dependencies and run migrations. You can see progress in the terminal window.
* After necessary scripts are run you will see message saying "Apache server is running ..., browser your project using 'localhost'". Now you can browse your project using localhost.

## SSH connect inside laravel_web service
* Make sure docker container is running
* CD to "laravelapache-docker" folder or root of this project
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


