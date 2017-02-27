# Trying to have a resource in the private subnet access the external internet

## Contents

* VPC
* Public subnet
* Private subnet
* EC2 instance in public subnet acting as website
* EC2 instance in private subnet acting as API server

Ask Fellows to diagnose why data is coming through from the API server

## Solution

* Recognize that the API server has no access to the internet and can't pull data from github.com
* Need to setup a NAT server in the public subnet and make sure all outbound traffic from the API server is routed to the NAT instance
