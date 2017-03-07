resource "aws_security_group" "wom3-client-2" {
    name = "wom3-client-2"
    description = "Website level security groups."

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

    vpc_id = "${aws_vpc.wom3-2.id}"

    tags {
        Name = "wom3-client-2"
    }
}

resource "aws_instance" "wom3-client-2" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-west-2a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.wom3-client-2.id}"]
    subnet_id = "${aws_subnet.wom3-public-2-1.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "wom3-client-2"
    }
}

resource "aws_eip" "wom3-client-2" {
    instance = "${aws_instance.wom3-client-2.id}"
    vpc = true
}
