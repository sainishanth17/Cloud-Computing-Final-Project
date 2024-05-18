resource "aws_db_subnet_group" "private_db" {
  name = "private_db"
  subnet_ids = var.db_subnet_ids
  tags = {
    Name = "private db subnet group"
  }
}

data "aws_db_snapshot" "db_snapshot" {
    most_recent = true
    db_instance_identifier = "ss-database"
}

resource "aws_db_instance" "ss-database" {
  identifier             = "ss-database"
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0.26"
  db_subnet_group_name   = aws_db_subnet_group.private_db.name
  instance_class         = var.db_instance_class
  username               = var.db_admin_username
  password               = var.db_admin_password
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [var.db_sg_id]
  snapshot_identifier = data.aws_db_snapshot.db_snapshot.id
}