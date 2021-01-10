module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  instance_count = var.instance_count

  name                        = "${var.app_prefix}-webserver"
  ami                         = data.aws_ami.latest-ubuntu.id
  instance_type               = "${var.instance_type}"
  vpc_security_group_ids      = [data.aws_security_group.default.id]
  subnet_id                   = element(tolist(data.aws_subnet_ids.all.ids), 0)
  associate_public_ip_address = true
  user_data                   = data.aws_s3_bucket_object.userdata.body

  tags = {
    Customer    = "${var.customer}"
    Environment = "${var.environment}"
  }

  provisioner "local-exec" {
    command = "aws s3 sync --delete s3://${var.app_prefix}-assets/html /var/www/html"
  }

  provisioner "local-exec" {
    command = '( crontab -l ; echo "*/1 * * * * root aws s3 sync --delete s3://${var.app_prefix}-assets/html /var/www/html" ) | crontab -'
  }

}
