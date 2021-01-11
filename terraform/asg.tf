######
# Launch configuration and autoscaling group
######
module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  name = "${var.app_prefix}-asg"

  # Launch configuration
  #
  # launch_configuration = "my-existing-launch-configuration" # Use the existing launch configuration
  # create_lc = false # disables creation of launch configuration
  lc_name = "${var.app_prefix}-lc"

  security_groups = [module.webserver_sg.this_security_group_id, data.aws_security_group.default.id]
  load_balancers  = [module.elb.this_elb_id]


  # Auto scaling group
  asg_name                  = "${var.app_prefix}-asg"
  vpc_zone_identifier       = data.aws_subnet_ids.all.ids
  health_check_type         = "EC2"
  min_size                  = 1
  max_size                  = 2
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  min_elb_capacity          = 1
  enable_monitoring         = var.enable_monitoring
  wait_for_elb_capacity     = 1


  image_id                    = data.aws_ami.latest-ubuntu.id
  instance_type               = var.instance_type
  associate_public_ip_address = true
  user_data                   = file("../provisioning/userdata.sh")

  tags = [
    {
      key                 = "Environment"
      value               = var.environment
      propagate_at_launch = true
    },
    {
      key                 = "Customer"
      value               = var.customer
      propagate_at_launch = true
    },
  ]

}
