output "public_sub_1_id" {
    value = aws_subnet.public_subnet_1.id
}

output "public_sub_2_id" {
    value = aws_subnet.public_subnet_2.id
}

output "public_sub_3_id" {
    value = aws_subnet.public_subnet_3.id
}

output "private_sub_1_id" {
    value = aws_subnet.private_subnet_1.id
}

output "private_sub_2_id" {
    value = aws_subnet.private_subnet_2.id
}

output "private_sub_3_id" {
    value = aws_subnet.private_subnet_3.id
}

output "private_db_sub_1_id" {
    value = aws_subnet.private_db_subnet_1.id
}

output "private_db_sub_2_id" {
    value = aws_subnet.private_db_subnet_2.id
}

output "private_db_sub_3_id" {
    value = aws_subnet.private_db_subnet_3.id
}

output "public_security_group_id" {
    value = aws_security_group.public_sg.id
}

output "private_security_group_id" {
    value = aws_security_group.private_sg.id
}

output "db_security_group_id" {
    value = aws_security_group.db_sg.id
}

output "vpc_id" {
    value = aws_vpc.custom_vpc.id
}