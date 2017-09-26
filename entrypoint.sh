# Don't remove, this command is needed to start ssh server when docker is started
/usr/sbin/sshd;

cd /var/www/html/project;
# Creates laravel project if doesn't exists already
if [ -f composer.json ]; then
	echo "Laravel project exists";
	if [ -d vendor ]; then
		echo "Vendor folder exists not installing composer packages.";
	else
		echo "Install composer packages";
		composer install -vv;
	fi	
else
	echo "Laravel project doesn't exist, creating new ...";
 	composer -vvv create-project laravel/laravel /var/www/html/project --prefer-dist;
fi


php artisan migrate;

# Install Node dependencies from package.json file if exists
if [ -f /var/www/html/project/package.json ]; then
	if [ -d /var/www/html/project/node_modules ]; then
		echo "Node modules already installed";
	else
		echo "Install node modules";
		npm --prefix /var/www/html/project install /var/www/html/project;
	fi	
else
	echo "No package.json file";
fi


# make following folders accessible to apache
chgrp -R www-data /var/www/html/project/storage;
chgrp -R www-data /var/www/html/project/bootstrap/cache;
chmod -R 777 /var/www/html/project/storage;


#Launch apache in the foreground
#We do this in the forground so that Docker can watch
#the process to detect if it has crashed
apache2 -DFOREGROUND;

echo "Apache server is running ..., browser your project using 'localhost' ";


