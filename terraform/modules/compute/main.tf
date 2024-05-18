data "aws_ami" "ss_ami" {
  most_recent      = true
  name_regex       = "ss-app-*"
  owners           = ["self"]
}

data "cloudinit_config" "app_config" {
  gzip          = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/app.yml", {
      region : var.region,
      bucket_name : var.bucket_name
      database_user: var.db_user
      database_pass: var.db_password
      database_host: var.db_host
      database_name: var.db_name
    })
  }
}

resource "aws_launch_template" "ss_launch_template" {
  name_prefix = "ss-app"
  image_id = "${data.aws_ami.ss_ami.id}"
  instance_type = "t2.micro"
  user_data = "${data.cloudinit_config.app_config.rendered}"
  iam_instance_profile {name = var.instance_profile_name}
  vpc_security_group_ids = [var.private_security_group_id]
}

resource "aws_autoscaling_group" "ss-asg" {
    name                = "ss-asg-%d"
    max_size            = 3
    min_size            = 3
    health_check_grace_period = 300
    health_check_type = "ELB"
    desired_capacity    = 3
    force_delete        = true
    termination_policies = ["OldestInstance"]
    vpc_zone_identifier = var.private_subnet_ids
    target_group_arns = [var.target_group_arn]
    launch_template {
        id      = aws_launch_template.ss_launch_template.id
        version = "$Latest"
    }
}