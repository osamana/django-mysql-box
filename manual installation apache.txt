#!/bin/bash

sudo apt-get update
sudo apt-get install python-pip apache2 libapache2-mod-wsgi
sudo pip install virtualenv
# install virtualenvwrapper
sudo pip install virtualenvwrapper
# create a dir to store your virtualenvs
mkdir ~/.virtualenvs
# Set WORKON_HOME to your virtualenv dir
export WORKON_HOME=~/.virtualenvs

# Add virtualenvwrapper.sh to .bashrc
# Add this line to the end of ~/.bashrc so that the virtualenvwrapper commands are loaded.
. /usr/local/bin/virtualenvwrapper.sh
# Exit and re-open your shell, or reload .bashrc with the command . .bashrc and you’re ready to go.


# Create a new virtualenv
mkvirtualenv env
# to exit your new virtualenv, use deactivate.
# Switch between enviornments with workon
# To load or switch between virtualenvs, use the workon command:
workon env

pip install django
# move to the project directory
django-admin.py startproject osamasiteproject .
nano myproject/settings.py - add: STATIC_ROOT = os.path.join(BASE_DIR, "static/")



cd ~/myproject
./manage.py makemigrations
./manage.py migrate

./manage.py createsuperuser
./manage.py collectstatic





########################################################################################################################
########################################################################################################################
                                                    sample host file
########################################################################################################################
########################################################################################################################


# ************************************
# Vhost template in module puppetlabs-apache
# Managed by Puppet
# ************************************

<VirtualHost *:80>
  ServerName osamasite.dev

 #Alias /robots.txt /path/to/mysite.com/static/robots.txt
 #Alias /favicon.ico /path/to/mysite.com/static/favicon.ico

Alias /media /var/www/osamasite/media
 #Alias /static/ /path/to/mysite.com/static/

  ## Directories, there should at least be a declaration for /var/www/osamasite
  ## Vhost docroot
  DocumentRoot "/var/www"

  Alias /static /var/www/osamasite/static
  <Directory /var/www/osamasite/static>
      Require all granted
  </Directory>

  <Directory /var/www/osamasite/media>
Require all granted
</Directory>


  <Directory /var/www/osamasite/osamasiteproject>
      <Files wsgi.py>
          Require all granted
      </Files>
  </Directory>

  WSGIDaemonProcess osamasite python-path=/var/www/osamasite:/home/vagrant/.virtualenvs/env/lib/python2.7/site-packages
  WSGIProcessGroup osamasite
  WSGIScriptAlias / /var/www/osamasite/osamasiteproject/wsgi.py process-group=osamasite

  <Directory "/var/www/osamasite">
    Options Indexes FollowSymlinks MultiViews
    AllowOverride All
    Require all granted
  </Directory>

  ## Logging
  ErrorLog "/var/log/apache2/av_zy2kgoxyepy5_error.log"
  ServerSignature Off
  CustomLog "/var/log/apache2/av_zy2kgoxyepy5_access.log" combined

  ## Server aliases
  ServerAlias www.osamasite.dev lovely-pig-1310.vagrantshare.com hulking-zebu-3423.vagrantshare.com

  ## SetEnv/SetEnvIf for environment variables
  SetEnv APP_ENV dev
  SetEnvIf Authorization "(.*)" HTTP_AUTHORIZATION=$1

  ## Custom fragment

</VirtualHost>
