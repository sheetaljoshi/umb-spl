module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  instance_count = var.instance_count

  name                        = "${var.app_prefix}-webserver"
  ami                         = data.aws_ami.latest-ubuntu.id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [data.aws_security_group.default.id]
  subnet_id                   = element(tolist(data.aws_subnet_ids.all.ids), 0)
  associate_public_ip_address = true
  user_data                   = data.aws_s3_bucket_object.userdata.body
  iam_instance_profile        = aws_iam_instance_profile.assets_iam_profile.name

  tags = {
    Customer    = "${var.customer}"
    Environment = "${var.environment}"
  }

}
