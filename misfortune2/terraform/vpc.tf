/*
  VPC
*/
resource "aws_vpc" "wom2" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "wom2"
    }
}

/*
  IGW
*/
resource "aws_internet_gateway" "wom2" {
    vpc_id = "${aws_vpc.wom2.id}"

    tags {
        Name = "wom2"
    }
}

/*
  Public Subnet in VPC
*/
resource "aws_subnet" "wom2-public" {
    vpc_id = "${aws_vpc.wom2.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-west-2a"

    tags {
        Name = "wom2-public"
    }
}

resource "aws_route_table" "wom2" {
    vpc_id = "${aws_vpc.wom2.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.wom2.id}"
    }

    tags {
        Name = "wom2"
    }
}

resource "aws_route_table_association" "wom2" {
    subnet_id = "${aws_subnet.wom2-public.id}"
    route_table_id = "${aws_route_table.wom2.id}"
}

/*
  Private Subnet in VPC
*/
resource "aws_subnet" "wom2-private" {
    vpc_id = "${aws_vpc.wom2.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "us-west-2a"

    tags {
        Name = "wom2-private"
    }
}
