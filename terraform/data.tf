data "aws_route53_zone" "route_53" {
  name         = "${var.app_prefix}.com"
  private_zone = false
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}

data "aws_elb_service_account" "this" {}

data "aws_s3_bucket" "assets" {
  bucket = "assets"
}

data "aws_s3_bucket" "provisioning" {
  bucket = "provisioning"
}

data "aws_s3_bucket_object" "userdata" {
  bucket = "provisioning"
  key    = "userdata.sh"
}

data "aws_ami" "latest-ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name = "name"
    # values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

