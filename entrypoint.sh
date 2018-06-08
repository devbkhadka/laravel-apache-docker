#!/bin/bash
# Don't remove, this command is needed to start ssh server when docker is started
/usr/sbin/sshd;


echo $BUILD_TYPE;
echo $1;

# cd /var/www/html/project;
# # Creates laravel project if doesn't exists already
# if [ -f composer.json ]; then
# 	echo "Laravel project exists";
# 	if [ -d vendor ]; then
# 		echo "Vendor folder exists not installing composer packages.";
# 	else
# 		echo "Install composer packages";
# 		composer install -vv;
# 	fi	
# else
# 	echo "Laravel project doesn't exist, creating new ...";
#  	composer -vvv create-project laravel/laravel /var/www/html/project --prefer-dist;
# fi


# # Install Node dependencies from package.json file if exists
# if [ -f package.json ]; then
# 	if [ -d node_modules ]; then
# 		echo "Node modules already installed";
# 	else
# 		echo "Install node modules";
# 		npm install;
# 	fi	
# else
# 	echo "No package.json file";
# fi


# make following folders accessible to apache
chgrp -R www-data /var/www/html/project/storage;
chgrp -R www-data /var/www/html/project/bootstrap/cache;
chmod -R 777 /var/www/html/project/storage;

# echo "Running migration...";
# php artisan migrate;


echo "Apache server is running ..., browse your project using 'localhost' ";
#Launch apache in the foreground
#We do this in the forground so that Docker can watch
#the process to detect if it has crashed
apache2 -DFOREGROUND;





