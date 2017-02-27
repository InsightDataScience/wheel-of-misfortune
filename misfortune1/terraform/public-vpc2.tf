/*
  RDS Server
*/
resource "aws_security_group" "wom1-rds" {
    name = "wom-rds"
    description = "Allow incoming RDS connections."

    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.wom1-2.id}"

    tags {
        Name = "wom1-rds-sg"
    }
}

resource "aws_db_subnet_group" "wom1-rds" {
    name = "wom1-rds"
    subnet_ids = [
        "${aws_subnet.wom1-vpc2-1.id}",
        "${aws_subnet.wom1-vpc2-2.id}"
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

