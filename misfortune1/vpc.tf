resource "aws_vpc" "wom1" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "wom1-aws-vpc"
    }
}

resource "aws_internet_gateway" "wom1" {
    vpc_id = "${aws_vpc.wom1.id}"
}

/*
  Public Subnet
*/
resource "aws_subnet" "wom1-public" {
    vpc_id = "${aws_vpc.wom1.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-1a"

    tags {
        Name = "Public Subnet"
    }
}

resource "aws_route_table" "wom1-public" {
    vpc_id = "${aws_vpc.wom1.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.wom1.id}"
    }

    tags {
        Name = "Public Subnet"
    }
}

resource "aws_route_table_association" "wom1-public" {
    subnet_id = "${aws_subnet.wom1-public.id}"
    route_table_id = "${aws_route_table.wom1-public.id}"
}

/*
  Private Subnet
*/
resource "aws_subnet" "wom1-private" {
    vpc_id = "${aws_vpc.wom1.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "us-east-1a"

    tags {
        Name = "Private Subnet"
    }
}
