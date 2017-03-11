/*
  API Server
*/
resource "aws_security_group" "wom2-api" {
    name = "wom2-api"
    description = "Allow incoming API connections."

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        security_groups = ["${aws_security_group.wom2-client.id}"]
    }

    ingress {
        from_port = 9999
        to_port = 9999
        protocol = "udp"
        security_groups = ["${aws_security_group.wom2-client.id}"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.wom2.id}"

    tags {
        Name = "wom2-api"
    }
}

resource "aws_instance" "wom2-api" {
    ami = "${lookup(var.amis-api, var.aws_region)}"
    availability_zone = "us-west-2a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.wom2-api.id}"]
    subnet_id = "${aws_subnet.wom2-private.id}"
    associate_public_ip_address = false
    source_dest_check = false

    tags {
        Name = "wom2-api"
    }
}
