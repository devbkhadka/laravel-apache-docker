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
 <br>project
  <br>|--app
  <br>|--bootstrap
  <br>|--config
  <br>|--database
  <br>|--...
  <br>|--...
  <br>|--.env
  <br>|--composer.json
  <br>|--...
 * Open terminal and CD to "laravelapache-docker" folder or root of this project
 * Run following command to build a docker image
 ''' docker build -t laravelapache .
 
