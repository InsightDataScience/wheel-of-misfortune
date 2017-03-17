/*
  Server
*/
resource "aws_security_group" "wom4" {
    name = "wom4"
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

    vpc_id = "${aws_vpc.wom4.id}"

    tags {
        Name = "wom4"
    }
}

resource "aws_instance" "wom4-client" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-west-2a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.wom4.id}"]
    subnet_id = "${aws_subnet.wom4.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "wom4-client"
    }
}

resource "aws_eip" "wom4-client" {
    instance = "${aws_instance.wom4-client.id}"
    vpc = true
}

resource "aws_instance" "wom4-api" {
    ami = "${lookup(var.amis-api, var.aws_region)}"
    availability_zone = "us-west-2a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.wom4.id}"]
    subnet_id = "${aws_subnet.wom4.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "wom4-api"
    }
}

resource "aws_eip" "wom4-api" {
    instance = "${aws_instance.wom4-api.id}"
    vpc = true
}
