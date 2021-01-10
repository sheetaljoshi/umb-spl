module "http_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/http-80"

  name        = "${var.app_prefix}-http-sg"
  description = "Security group with HTTP ports open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

