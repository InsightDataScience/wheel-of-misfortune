/*
  VPC
*/
resource "aws_vpc" "wom3-1" {
    cidr_block = "${var.vpc_cidr_1}"
    enable_dns_hostnames = true
    tags {
        Name = "wom3-1"
    }
}

resource "aws_vpc" "wom3-2" {
    cidr_block = "${var.vpc_cidr_2}"
    enable_dns_hostnames = true
    tags {
        Name = "wom3-2"
    }
}

/*
  IGW
*/
resource "aws_internet_gateway" "wom3-1" {
    vpc_id = "${aws_vpc.wom3-1.id}"

    tags {
        Name = "wom3-1"
    }
}

resource "aws_internet_gateway" "wom3-2" {
    vpc_id = "${aws_vpc.wom3-2.id}"

    tags {
        Name = "wom3-2"
    }
}

/*
  Public Subnet in VPC
*/
resource "aws_subnet" "wom3-public-1-1" {
    vpc_id = "${aws_vpc.wom3-1.id}"

    cidr_block = "${var.public_subnet_cidr_1_1}"
    availability_zone = "us-west-2a"

    tags {
        Name = "wom3-public-1-1"
    }
}

resource "aws_subnet" "wom3-public-1-2" {
    vpc_id = "${aws_vpc.wom3-1.id}"

    cidr_block = "${var.public_subnet_cidr_1_2}"
    availability_zone = "us-west-2b"

    tags {
        Name = "wom3-public-1-2"
    }
}

resource "aws_subnet" "wom3-public-2-1" {
    vpc_id = "${aws_vpc.wom3-2.id}"

    cidr_block = "${var.public_subnet_cidr_2_1}"
    availability_zone = "us-west-2a"

    tags {
        Name = "wom3-public-2-1"
    }
}

resource "aws_subnet" "wom3-public-2-2" {
    vpc_id = "${aws_vpc.wom3-2.id}"

    cidr_block = "${var.public_subnet_cidr_2_2}"
    availability_zone = "us-west-2b"

    tags {
        Name = "wom3-public-2-2"
    }
}

resource "aws_route_table" "wom3-1" {
    vpc_id = "${aws_vpc.wom3-1.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.wom3-1.id}"
    }

    tags {
        Name = "wom3-1"
    }
}

resource "aws_route_table" "wom3-2" {
    vpc_id = "${aws_vpc.wom3-2.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.wom3-2.id}"
    }

    tags {
        Name = "wom3-2"
    }
}

resource "aws_route_table_association" "wom3-1-1" {
    subnet_id = "${aws_subnet.wom3-public-1-1.id}"
    route_table_id = "${aws_route_table.wom3-1.id}"
}

resource "aws_route_table_association" "wom3-1-2" {
    subnet_id = "${aws_subnet.wom3-public-1-2.id}"
    route_table_id = "${aws_route_table.wom3-1.id}"
}

resource "aws_route_table_association" "wom3-2-1" {
    subnet_id = "${aws_subnet.wom3-public-2-1.id}"
    route_table_id = "${aws_route_table.wom3-2.id}"
}

resource "aws_route_table_association" "wom3-2-2" {
    subnet_id = "${aws_subnet.wom3-public-2-2.id}"
    route_table_id = "${aws_route_table.wom3-2.id}"
}


