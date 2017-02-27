/*
  VPCs
*/
resource "aws_vpc" "wom1-1" {
    cidr_block = "${var.vpc_cidr_1}"
    enable_dns_hostnames = true
    tags {
        Name = "wom1-1"
    }
}

resource "aws_vpc" "wom1-2" {
    cidr_block = "${var.vpc_cidr_2}"
    enable_dns_hostnames = true
    tags {
        Name = "wom1-2"
    }
}

/*
  IGWs
*/
resource "aws_internet_gateway" "wom1-1" {
    vpc_id = "${aws_vpc.wom1-1.id}"

    tags {
        Name = "wom1-1"
    }
}

resource "aws_internet_gateway" "wom1-2" {
    vpc_id = "${aws_vpc.wom1-2.id}"

    tags {
        Name = "wom1-2"
    }
}

/*
  Public Subnet in VPC1
*/
resource "aws_subnet" "wom1-vpc1-1" {
    vpc_id = "${aws_vpc.wom1-1.id}"

    cidr_block = "${var.public_subnet_cidr_vpc1_1}"
    availability_zone = "us-east-1a"

    tags {
        Name = "Public Subnet"
    }
}

resource "aws_route_table" "wom1-vpc1-1" {
    vpc_id = "${aws_vpc.wom1-1.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.wom1-1.id}"
    }

    tags {
        Name = "Public Route Table for VPC 1"
    }
}

resource "aws_route_table_association" "wom1-vpc1-1" {
    subnet_id = "${aws_subnet.wom1-vpc1-1.id}"
    route_table_id = "${aws_route_table.wom1-vpc1-1.id}"
}

/*
  Public Subnets in VPC2
*/
resource "aws_subnet" "wom1-vpc2-1" {
    vpc_id = "${aws_vpc.wom1-2.id}"

    cidr_block = "${var.public_subnet_cidr_vpc2_1}"
    availability_zone = "us-east-1a"

    tags {
        Name = "Private Subnet"
    }
}

resource "aws_subnet" "wom1-vpc2-2" {
    vpc_id = "${aws_vpc.wom1-2.id}"

    cidr_block = "${var.public_subnet_cidr_vpc2_2}"
    availability_zone = "us-east-1b"

    tags {
        Name = "Private Subnet"
    }
}

resource "aws_route_table" "wom1-vpc2-1" {
    vpc_id = "${aws_vpc.wom1-2.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.wom1-2.id}"
    }

    tags {
        Name = "Public Route Table for VPC 2"
    }
}

resource "aws_route_table_association" "wom1-vpc2-1" {
    subnet_id = "${aws_subnet.wom1-vpc2-1.id}"
    route_table_id = "${aws_route_table.wom1-vpc2-1.id}"
}
