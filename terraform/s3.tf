resource "aws_s3_bucket" "provisioning" {
  bucket        = "${var.app_prefix}-provisioning"
  acl           = "private"
  force_destroy = true

  tags = {
    Customer   = "${var.customer}"
    Environment = "${var.environment}"
  }
  
}

resource "aws_s3_bucket" "assets" {
  bucket = "${var.app_prefix}-assets"
  acl    = "private"
  force_destroy = true

  tags = {
    Customer    = "${var.customer}"
    Environment = "${var.environment}"
  }
}

resource "aws_s3_bucket_object" "assets_subdirectory" {
  for_each = fileset(path.module, "../assets/**/*.*")

  bucket = aws_s3_bucket.assets.bucket
  key    = each.value
  source = "${path.module}/${each.value}"
}

resource "aws_s3_bucket_object" "userdata" {
  bucket = aws_s3_bucket.provisioning.name
  key    = "userdata.sh"
  source = "../provisioning/userdata.sh"
}
