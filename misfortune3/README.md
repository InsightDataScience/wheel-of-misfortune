# Resource in the private subnet access the external internet

## Contents

* VPC
* Public subnet
* Private subnet
* EC2 instance in public subnet acting as client
* EC2 instance in private subnet acting as API server

## Goals to pass

Client should be able to hit the API server with a given user and receive all public repositories

  * GET request against WOM2-API-NODE:9999 to view Prometheus metrics
  * GET request against WOM2-API-NODE:5000 to view HTML of home page
  * GET request against WOM2-API-NODE:5000/get-repos?username={myusername}

## Helpful resources
* [NAT](http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_NAT_Instance.html)

