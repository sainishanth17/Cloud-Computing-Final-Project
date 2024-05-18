packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "social_something" {
  ami_name = "ss-app-${local.timestamp}"

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-2.*.1-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  #source_ami = "ami-013a129d325529d4d"


  instance_type = "t2.micro"
  region = "us-east-1"
  ssh_username = "ec2-user"
}

build {
  sources = [
    "source.amazon-ebs.social_something"
  ]

  provisioner "file" {
    source = "./social_something_full-master.zip"
    destination = "/home/ec2-user/social_something_full-master.zip"
  }

  provisioner "file" {
    source = "./socialsomething.service"
    destination = "/tmp/socialsomething.service"
  }

  provisioner "shell" {
    script = "./app.sh"
  }
  provisioner "file" {
    source = "./app.env"
    destination = "/home/ec2-user/social_something_full-master/app.env"
  }
}