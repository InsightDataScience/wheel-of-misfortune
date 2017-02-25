/*
  Web Servers
*/
resource "aws_security_group" "wom1-rds" {
    name = "vpc_rds"
    description = "Allow incoming RDS connections."

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["${var.public_subnet_cidr}"]
    }

    vpc_id = "${aws_vpc.wom1.id}"

    tags {
        Name = "wom1-rdsSG"
    }
}

resource "aws_db_subnet_group" "wom1-rds" {
    name = "wom1-rds"
    subnet_ids = [
        "${aws_subnet.wom1-1-private.id}",
        "${aws_subnet.wom1-2-private.id}"
    ]

    tags {
        Name = "Wheel of Misfortune DB Subnet Group"
    }
}

resource "aws_db_instance" "wom1-rds" {
    allocated_storage = 100
    engine = "postgres"
    engine_version = "9.5"
    instance_class = "db.t2.small"
    name = "myrds"
    username = "postgres"
    password = "postgres"
    backup_retention_period = 0
    vpc_security_group_ids = ["${aws_security_group.wom1-rds.id}"]
    db_subnet_group_name = "wom1-rds"
    publicly_accessible = true
    apply_immediately = true
}

