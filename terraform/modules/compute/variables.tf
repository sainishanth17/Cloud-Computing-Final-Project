variable "region" {
    description = "Region"
    type = string
}


variable "db_user" {
    description = "DB User"
    type = string
}

variable "db_password" {
    description = "DB Password"
    type = string
}

variable "db_name" {
    description = "DB Name"
    type = string
}

variable "db_host" {
    description = "DB Host"
    type = string
}

variable "bucket_name" {
    description = "Bucket Name"
    type = string
}

variable "private_availability_zones" {
    description = "Private Availability Zones"
    type = list
}

variable "private_security_group_id" {
    description = "Private Security Group ID"
    type = string
}

variable "private_subnet_ids" {
    description = "Private Subnet IDs"
    type = list
} 

variable "target_group_arn" {
    description = "Target Group ARN"
    type = string
}
variable "instance_profile_name" {
    description = "SS Instance Profile Name"
    type = string
}