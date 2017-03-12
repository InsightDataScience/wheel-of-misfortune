/*
  Spark Master
*/
resource "aws_security_group" "wom4-master" {
    name = "wom4-master"
    description = "Spark master security group."

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

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 4040
        to_port = 4040
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 8888
        to_port = 8888
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.wom4.id}"

    tags {
        Name = "wom4-master"
    }
}

resource "aws_instance" "wom4-master" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-west-2a"
    instance_type = "${var.instance_type}"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.wom4-master.id}"]
    subnet_id = "${aws_subnet.wom4.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "wom4-master"
        Misfortune = "wom4"
    }
}

resource "aws_eip" "wom4-master" {
    instance = "${aws_instance.wom4-master.id}"
    vpc = true
}

