# Trying to reach a resource with a Public DNS but in the private subnet

## Contents

* VPC
* Public subnet
* Private subnet
* EC2 instance in public subnet
* RDS postgres server in private subnet

Ask Fellows to write their name to `fellows` table in the database

## Solution

* Recognize that you cannot reference the Public DNS of a resource in the private subnet
* Redeploy a new RDS instance in the Private DNS using a snapshot of the previous RDS instance and reference the private DNS instead when using psql
* telnet from the ec2 machine to the RDS should connect
