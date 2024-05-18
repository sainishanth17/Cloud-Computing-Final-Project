resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "Some Custom VPC"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_sub_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = "Public Subnet 1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_sub_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = "Public Subnet 2"
  }
}

resource "aws_subnet" "public_subnet_3" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_sub_3_cidr
  availability_zone = var.availability_zone_3

  tags = {
    Name = "Public Subnet 3"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_sub_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = "Private Subnet 1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_sub_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = "Private Subnet 2"
  }
}

resource "aws_subnet" "private_subnet_3" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_sub_3_cidr
  availability_zone = var.availability_zone_3

  tags = {
    Name = "Private Subnet 3"
  }
}

resource "aws_subnet" "private_db_subnet_1" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_db_sub_1_cidr
  availability_zone = var.availability_zone_1

  tags = {
    Name = "Private DB Subnet 1"
  }
}

resource "aws_subnet" "private_db_subnet_2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_db_sub_2_cidr
  availability_zone = var.availability_zone_2

  tags = {
    Name = "Private DB Subnet 2"
  }
}

resource "aws_subnet" "private_db_subnet_3" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_db_sub_3_cidr
  availability_zone = var.availability_zone_3

  tags = {
    Name = "Private DB Subnet 3"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_1_rt_a" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_2_rt_a" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_3_rt_a" {
  subnet_id      = aws_subnet.public_subnet_3.id
  route_table_id = aws_route_table.public_rt.id
}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "Private Route Table"
  }
}
resource "aws_security_group" "public_sg" {
  name   = "HTTP and SSH"
  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_security_group" "private_sg" {
  name   = "Private HTTP"
  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "allow on port 3306 from any ip on ${var.vpc_cidr}"
  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.custom_vpc.id
  service_name = "com.amazonaws.${var.region}.s3"
}

resource "aws_vpc_endpoint_route_table_association" "s3" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  route_table_id  = aws_route_table.private_rt.id
}

resource "aws_security_group" "cloudwatch_sg" {
  name   = "cloudwatch_sg"
  vpc_id = aws_vpc.custom_vpc.id

  ingress {
    from_port   = 1
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
}

}

resource "aws_vpc_endpoint" "cloudwatch" {
  vpc_id       = aws_vpc.custom_vpc.id
  service_name = "com.amazonaws.${var.region}.logs"
  security_group_ids = [aws_security_group.cloudwatch_sg.id]
  vpc_endpoint_type = "Interface"
  subnet_ids = [aws_subnet.private_subnet_1.id, 
                aws_subnet.private_subnet_2.id, 
                aws_subnet.private_subnet_3.id
          ]
  private_dns_enabled = true
}