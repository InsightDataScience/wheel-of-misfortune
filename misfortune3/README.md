# Resource in the private subnet access the external internet

## Contents

* 2 VPCs
* 2 Public subnet
* 2 EC2 instances with one in each public subnet acting as client
* 2 RDS Postgres servers with one in each public subnet

## Goals to pass

Client from either subnet should be able to access their own RDS postgres server along with each others Postgres servers
  * Ensure each client instance can make a connection with their own database
  * Ensure each client instance can access each others database

## Helpful resources
* [RDS](https://aws.amazon.com/rds/postgresql/)
* [VPC Peering](http://docs.aws.amazon.com/AmazonVPC/latest/PeeringGuide/Welcome.html)
