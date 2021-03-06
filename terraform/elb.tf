module "elb" {
  source  = "terraform-aws-modules/elb/aws"
  version = "~> 2.0"
  name   = "${var.app_prefix}-classic-lb"

  subnets         = data.aws_subnet_ids.all.ids
  security_groups = [module.webserver_sg.this_security_group_id, data.aws_security_group.default.id]
  internal        = false

  listener = [
    {
      instance_port     = "80"
      instance_protocol = "http"
      lb_port           = "80"
      lb_protocol       = "http"
    }
  ]

  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }

  #access_logs = {
  #  bucket = aws_s3_bucket.logs.id
  #}

  tags = {
    Customer    = var.customer
    Environment = var.environment
  }

  # ELB attachments
  #number_of_instances = var.instance_count
  #instances           = module.ec2_instances.id
}
