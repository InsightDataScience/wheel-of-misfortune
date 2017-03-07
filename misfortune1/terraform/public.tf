/*
  Client
*/
resource "aws_security_group" "wom1-client" {
    name = "wom1-client"
    description = "wom1 client security group."

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.wom1.id}"

    tags {
        Name = "wom1-client"
    }
}

resource "aws_instance" "wom1-client" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-west-2a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.wom1-client.id}"]
    subnet_id = "${aws_subnet.wom1-vpc.id}"
    associate_public_ip_address = true
    source_dest_check = false
    count = "${var.client_cnt}"

    tags {
        Name = "wom1-client"
    }
}

resource "aws_eip" "wom1-client" {
    count = "${var.client_cnt}"
    instance = "${element(aws_instance.wom1-client.*.id, count.index)}"
    vpc = true
}

/*
  Server
*/
resource "aws_security_group" "wom1-server" {
    name = "wom1-server"
    description = "wom1 server security group."

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.wom1.id}"

    tags {
        Name = "wom1-server"
    }
}

resource "aws_instance" "wom1-server" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-west-2a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.wom1-server.id}"]
    subnet_id = "${aws_subnet.wom1-vpc.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "wom1-server"
    }
}

resource "aws_eip" "wom1-server" {
    instance = "${aws_instance.wom1-server.id}"
    vpc = true
}
