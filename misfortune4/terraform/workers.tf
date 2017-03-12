/*
  Spark Workers
*/
resource "aws_security_group" "wom4-worker" {
    name = "wom4-worker"
    description = "Spark worker security group."

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
        Name = "wom4-worker"
    }
}

resource "aws_instance" "wom4-worker" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-west-2a"
    instance_type = "${var.instance_type}"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.wom4-worker.id}"]
    subnet_id = "${aws_subnet.wom4.id}"
    associate_public_ip_address = true
    source_dest_check = false
    count = "${var.num_workers}"

    tags {
        Name = "wom4-worker"
        Misfortune = "wom4"
    }
}

resource "aws_eip" "wom4-worker" {
    count = "${var.num_workers}"
    instance = "${element(aws_instance.wom4-worker.*.id, count.index)}"
    vpc = true
}

