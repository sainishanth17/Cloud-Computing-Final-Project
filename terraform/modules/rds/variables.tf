variable "db_instance_class" {
    description = "The instance class to use"
    type = string
    default = "db.t2.micro"
    
}

variable "db_admin_username" {
    description = "The username for the DB admin"
    type = string
    default = "admin"
}

variable "db_admin_password" {
    description = "The password for the DB admin"
    type = string
}

variable "db_sg_id" {
    description = "The security group id for the DB"
    type = string
}

variable "db_subnet_ids" {
    description = "The subnet ids for the DB"
    type = list
}