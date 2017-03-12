# Allow two VPCs to share their RDS postgres databases

## Contents

* 2 VPCs
* 1 Public subnet in each VPC
* EC2 instance in each public subnet acting as client
* RDS Postgres instance in each public subnet acting as a backend DB

## Goals to pass

* EC2 instance in each VPC should be able to connect with their own RDS Postgres instance
* EC2 instance in each VPC should be able to connect to each others RDS Postgres instance

## Helpful resources
* [VPC Peering](http://docs.aws.amazon.com/AmazonVPC/latest/PeeringGuide/Welcome.html)

