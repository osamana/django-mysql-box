#!/usr/bin/env bash

cd $(dirname $0)/mydjango
python manage.py runserver 0.0.0.0:8000
