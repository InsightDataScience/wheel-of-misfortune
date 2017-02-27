/*
  Web Servers
*/
resource "aws_security_group" "wom2-client" {
    name = "wom2-client"
    description = "Client level security groups."

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

    vpc_id = "${aws_vpc.wom2.id}"

    tags {
        Name = "wom2-client"
    }
}

resource "aws_instance" "wom2-client" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.wom2-client.id}"]
    subnet_id = "${aws_subnet.wom2-public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "wom2-client"
    }
}

resource "aws_eip" "wom2-client" {
    instance = "${aws_instance.wom2-client.id}"
    vpc = true
}
