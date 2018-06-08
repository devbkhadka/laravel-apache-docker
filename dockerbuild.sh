#!/bin/bash

#This script calls the "docker build" command for development or production environment base on parameter passed
#For development environment it sends build argument "PROJECT_DIR=project" which will be mapped as application directory in container. Any changes in project directory is reflected in container without doing docker build again.
#For production environment we want project directory to be included in docker image file so we send "PROJECT_DIR=project.conf" where project.conf is a random file

#Rather then sending build argument to docker build file it may be better to change docker file it self with this script. Also we need to change docker-compose.yaml not to map project folder as volume.


dev_build_args=("BUILD_TYPE=dev"
	"PROJECT_DIR=project");
prod_build_args=("BUILD_TYPE=prod" 
	"PROJECT_DIR=project.conf");

while getopts 't:e:' opt; do
    case $opt in
        t) tag="$OPTARG" ;;
        e) eenv="$OPTARG";;
        *)  exit 1            ;;
    esac
done


if [ -z $tag ] || [ -z $eenv ]; then
	echo "Please provide parameters";
	echo "-t = docker build tag";
	echo "-e = env, either 'dev' or 'prod'";
	exit 1;
else
	echo "parameters are good";
fi

if [ "dev" == $eenv ]; then
	build_args=(${dev_build_args[@]});
elif [ "prod" == $eenv ]; then
	build_args=(${prod_build_args[@]})
else
 	echo "Please give valid option, either 'prod' or 'dev'";
 	exit 1;
fi


cmd="docker build -t $tag ";

echo ${dev_build_args[@]};
for arg in "${build_args[@]}";
do
	cmd+="--build-arg \"$arg\" ";
	echo $arg;
done

cmd+="."

echo "Running: " $cmd;


eval $cmd;




