#!/bin/bash

sudo apt-get update &&
    sudo apt-get install -y git python-pip python-dev

sudo pip install flask requests prometheus_client tornado

git clone https://github.com/InsightDataScience/flask-kube-prometheus.git /home/ubuntu/flask-kube-prometheus

