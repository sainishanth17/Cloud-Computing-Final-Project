variable "region" {
    description = "Region"
    type = string
}

variable "vpc_cidr" {
  description = "CIDR block for the entire VPC"
  type        = string
}

variable "public_sub_1_cidr" {
    description = "CIDR block for public subnet #1"
    type = string
}

variable "public_sub_2_cidr" {
    description = "CIDR block for public subnet #2"
    type = string
}

variable "public_sub_3_cidr" {
    description = "CIDR block for public subnet #3"
    type = string
}

variable "private_sub_1_cidr" {
    description = "CIDR block for private subnet #1"
    type = string
}

variable "private_sub_2_cidr" {
    description = "CIDR block for private subnet #2"
    type = string
}

variable "private_sub_3_cidr" {
    description = "CIDR block for private subnet #3"
    type = string
}

variable "private_db_sub_1_cidr" {
    description = "CIDR block for private db subnet #1"
    type = string
}

variable "private_db_sub_2_cidr" {
    description = "CIDR block for private db subnet #2"
    type = string
}

variable "private_db_sub_3_cidr" {
    description = "CIDR block for private db subnet #3"
    type = string
}


variable "availability_zone_1" {
    description = "Availability Zone for public and private subnet #1"
    type = string
}

variable "availability_zone_2" {
    description = "Availability Zone for public and private subnet #2"
    type = string
}

variable "availability_zone_3" {
    description = "Availability Zone for public and private subnet #3"
    type = string
}