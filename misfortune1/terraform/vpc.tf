/*
  VPCs
*/
resource "aws_vpc" "wom1" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "wom1"
    }
}

/*
  IGWs
*/
resource "aws_internet_gateway" "wom1" {
    vpc_id = "${aws_vpc.wom1.id}"

    tags {
        Name = "wom1"
    }
}

/*
  Public Subnet in VPC
*/
resource "aws_subnet" "wom1-vpc" {
    vpc_id = "${aws_vpc.wom1.id}"

    cidr_block = "${var.public_subnet_cidr_vpc}"
    availability_zone = "us-west-2a"

    tags {
        Name = "Public Subnet"
    }
}

resource "aws_route_table" "wom1-vpc" {
    vpc_id = "${aws_vpc.wom1.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.wom1.id}"
    }

    tags {
        Name = "Public Route Table for VPC"
    }
}

resource "aws_route_table_association" "wom1-vpc" {
    subnet_id = "${aws_subnet.wom1-vpc.id}"
    route_table_id = "${aws_route_table.wom1-vpc.id}"
}
