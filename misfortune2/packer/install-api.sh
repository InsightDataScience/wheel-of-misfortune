#!/bin/bash

sudo apt-get update &&
     sudo apt-get install -y python-pip git

sudo pip install flask tornado requests prometheus_client

git clone https://github.com/InsightDataScience/flask-kube-prometheus /home/ubuntu/myapp


