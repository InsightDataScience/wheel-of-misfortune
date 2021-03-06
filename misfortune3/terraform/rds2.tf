/*
  RDS
*/
resource "aws_security_group" "wom3-rds-2" {
    name = "wom3-rds-2"
    description = "Website level security groups."

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        security_groups = ["${aws_security_group.wom3-client-2.id}"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.wom3-2.id}"

    tags {
        Name = "wom3-rds-2"
    }
}

resource "aws_db_subnet_group" "wom3-rds-2" {
    name = "wom3-rds-2"
    subnet_ids = [
        "${aws_subnet.wom3-public-2-1.id}",
        "${aws_subnet.wom3-public-2-2.id}"
    ]
    tags {
        Name = "My DB subnet group"
    }
}

resource "aws_db_instance" "wom3-rds-2" {
    instance_class = "db.t2.micro"
    name = "db2"
    engine = "postgres"
    engine_version = "9.5"
    allocated_storage = "100"
    username = "postgres"
    password = "postgres"
    db_subnet_group_name = "${aws_db_subnet_group.wom3-rds-2.id}"
    vpc_security_group_ids = ["${aws_security_group.wom3-rds-2.id}"]

    tags {
        Name = "wom3-rds-2"
    }
}


