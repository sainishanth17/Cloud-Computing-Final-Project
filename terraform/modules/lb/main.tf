

resource "aws_lb" "ss_lb" {
    name = "ss-app-lb"
    internal  = false
    load_balancer_type = "application"
    security_groups = [var.public_security_group_id]
    subnets = var.public_subnet_ids
}

resource "aws_lb_listener" "ss_alb_listener" {
    load_balancer_arn = aws_lb.ss_lb.arn
    port = "80"
    protocol = "HTTP"
    default_action {
        target_group_arn = aws_lb_target_group.ss_target_group.arn
        type = "forward"
    }

}

resource "aws_lb_listener" "ss_alb_listener_https" {
    load_balancer_arn = aws_lb.ss_lb.arn
    port = "443"
    protocol = "HTTPS"
    ssl_policy = "ELBSecurityPolicy-2015-05"
    certificate_arn = var.ssl_cert_arn

    default_action {
        target_group_arn = aws_lb_target_group.ss_target_group.arn
        type = "forward"
    }

}


resource "aws_lb_target_group" "ss_target_group" {
  name     = "ss-target-group"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}