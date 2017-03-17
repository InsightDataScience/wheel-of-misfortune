# Two instances in public subnets can talk with each other but the API server does not get a response from Github.com.

## Contents

* VPC
* 1 Public subnet
* 1 EC2 instance acting as client
* 1 EC2 instance acting as an API server
  * Tornado web server on port 5000
  * Prometheus web server on port 9999

## Goals to pass

* Make a GET request to the server on port 5000 from the client
* Make a GET request to the server on port 9999 from the client
* Make a GET request to one of the endpoing on the server
    * SERVERIP:5000/get-repos?username=aouyang1

## Helpful resources

* [DNS](https://www.youtube.com/watch?v=72snZctFFtA)
* [resolv.conf](https://en.wikipedia.org/wiki/Resolv.conf)

