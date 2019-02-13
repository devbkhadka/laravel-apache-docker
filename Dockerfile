FROM devkhadka/ubuntuwithssh:1.0.2

#update package database 
#install php and php extensions required by laravel
#PHP >= 5.5.9
#OpenSSL PHP Extension
#PDO PHP Extension
#Mbstring PHP Extension
#Tokenizer PHP Extension

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y apache2 php7.0 libapache2-mod-php7.0 php7.0-mbstring php7.0-zip php7.0-xml php7.0-mysql curl php7.0-curl

#Install NodeJS
RUN apt-get install -y nodejs npm

#install composer, which is dependency manager for laravel
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer



#restart apache server and enable url rewrite mode
RUN service apache2 stop && a2enmod rewrite


#add virtual host configuration of the site
ADD 000-default.conf /etc/apache2/sites-available/000-default.conf


#Set the ENV vars
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2


ADD entrypoint.sh /root/entrypoint.sh
RUN chmod 777 /root/entrypoint.sh
ENTRYPOINT /root/entrypoint.sh



EXPOSE 80
