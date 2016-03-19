`v0.1 last update 19 Mar 2016`

\# Install VirtualBox 4.3.36-105129

    https://www.virtualbox.org/wiki/Download_Old_Builds_4_3

\# Install Vagrant 1.8.1

    https://www.vagrantup.com/downloads.html

\# Open command prompt

\# cd to source code dir and clone repo

    git clone https://github.com/senoadiw/mydjango.git

\# Rename Vagrantfile.example to Vagrantfile

    cd mydjango
    cp Vagrantfile.example Vagrantfile

\# Start the Vagrant VM

    vagrant up

\# Wait until first-time Vagrant provisioning completes

\# ssh to the VM and activate the mydjango virtualenv

    vagrant ssh
    workon mydjango
    cd mydjango
    ls

\# Create a new Django project

    django-admin startproject mydjango

\# Configure Django settings file to use mydjango database

    cd mydjango
    vi mydjango/settings.py

\# Run the first database migration

    ./manage.py makemigrations
    ./manage.py migrate

\# Create the superuser account (admin admin123)

    python manage.py createsuperuser

\# Test by running the development server

    ./manage.py runserver 0.0.0.0:8000
    or
    ../run_server.sh

\# On host computer browser open http://localhost:8000

\# Exit shell and shutdown VM

    exit
    vagrant halt

\# Done! To start VM again just run: vagrant up
