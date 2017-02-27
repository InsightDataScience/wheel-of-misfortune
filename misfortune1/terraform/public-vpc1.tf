/*
  Web Servers
*/
resource "aws_security_group" "wom1-web" {
    name = "wom1-web"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
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

    vpc_id = "${aws_vpc.wom1-1.id}"

    tags {
        Name = "wom1-web"
    }
}

resource "aws_instance" "wom1-web" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-east-1a"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.wom1-web.id}"]
    subnet_id = "${aws_subnet.wom1-vpc1-1.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "wom1-web"
    }
}

resource "aws_eip" "wom1-web" {
    instance = "${aws_instance.wom1-web.id}"
    vpc = true
}
