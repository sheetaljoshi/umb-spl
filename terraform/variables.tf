
variable "app_prefix" {
  description = "Application prefix for the AWS services that are built"
  default     = "ciscoumb"
}

variable "environment" {
  default = "dev"
  type    = string
}

variable "customer" {
  default = "cisco"
  type    = string
}

variable "aws_credentials_path" {
  default = "~/.aws/credentials"
}

variable "region" {
  default = "us-east-1"
  type = string
}

variable "profile" {
  default = "ciscoumb"
}

variable "autoscale" {
  default = true
}

variable enable_monitoring {
  default = true
}

variable "instance_count" {
  description = "Number of instances to launch"
  type        = number
  default     = 2
}

#variable "key_name" {
#  description = "AWS EC2 Key name for SSH access"
#  type        = string
#}

variable "domain_name" {
    description = "Domain Name"
    type = string 
    default = ""
    
}

variable "platform" {
  description = "Name of the OS platform"
  type        = string
  default     = "ubuntu"
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
  default     = null
}

variable "vpc_subnet_id" {
  description = "The VPC Subnet ID to launch in"
  type        = string
  default     = ""
}

variable "vpc_subnet_ids" {
  description = "A list of VPC Subnet IDs to launch in"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  type        = bool
  default     = true
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  type        = string
  default     = null
}

variable "private_ips" {
  description = "A list of private IP address to associate with the instance in a VPC. Should match the number of instances."
  type        = list(string)
  default     = []
}
