provider "aws" {
  shared_credentials_file = var.aws_credentials_path
  alias                   = "ciscoumb"
  profile                 = var.profile
  region                  = var.region
}
