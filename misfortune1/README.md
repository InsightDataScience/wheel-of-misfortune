# Reach a resource with different protocols from multiple clients. Modify the AWS infrastructure to pass all the goals.

## Contents

* VPC
* Public subnet
* 4 EC2 instances acting as clients
* 1 EC2 isntance acting as a server
  * Nginx web server on HTTP port
  * Nginx web server on port 5000
  * Postgres on port 5432

## Goals to pass

* Ping the server node from any of the clients
* Make a GET request to the server on HTTP from any of the clients
* Make a GET request to the server on port 5000 from any of the clients
* Establish a connection to Postgresql in the server on port 5432 from any of the clients
* All connections should be accessible only from the clients

## Helpful resources

* [AWS Security Groups](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html)
* [ICMP/TCP/UDP](http://superuser.com/a/1044369)
* [NGINX](http://nginx.org/en/)
