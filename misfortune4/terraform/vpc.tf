/*
  VPC
*/
resource "aws_vpc" "wom4" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "wom4"
    }
}

/*
  IGW
*/
resource "aws_internet_gateway" "wom4" {
    vpc_id = "${aws_vpc.wom4.id}"

    tags {
        Name = "wom4"
    }
}

/*
  Public Subnet in VPC
*/
resource "aws_subnet" "wom4" {
    vpc_id = "${aws_vpc.wom4.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-west-2a"

    tags {
        Name = "wom4"
    }
}

resource "aws_route_table" "wom4" {
    vpc_id = "${aws_vpc.wom4.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.wom4.id}"
    }

    tags {
        Name = "wom4"
    }
}

resource "aws_route_table_association" "wom4" {
    subnet_id = "${aws_subnet.wom4.id}"
    route_table_id = "${aws_route_table.wom4.id}"
}

