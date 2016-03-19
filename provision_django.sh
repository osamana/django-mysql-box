#!/usr/bin/env bash
# User level script to set up environment for Django development on Vagrant.
# Target box: ubuntu/trusty64

echo "---------------------------------------------"
echo "Creating mydjango virtualenv"
echo "---------------------------------------------"
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    source /usr/local/bin/virtualenvwrapper.sh
elif [ -f /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]; then
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
else
    source /usr/bin/virtualenvwrapper.sh
fi

if [ ! -d /home/vagrant/.virtualenvs/mydjango ]; then
    mkvirtualenv --no-site-packages mydjango
fi

workon mydjango
cd mydjango

echo "---------------------------------------------"
echo "Setting up Django"
echo "---------------------------------------------"
pip install -r requirements.txt
nodeenv -p --prebuilt
workon opendims
npm install -g bower

echo "---------------------------------------------"
echo "Provisioning complete"
echo "---------------------------------------------"
printf "Use the following database connection settings in settings.py:
DATABASES = {
    'default': {
        'ENGINE': 'django.contrib.gis.db.backends.postgis',
        'NAME': 'mydjango',
        'USER': 'mydjango',
        'PASSWORD': 'password',
        'HOST': 'localhost',
        'PORT': '',
    }
}
"
