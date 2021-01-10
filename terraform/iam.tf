resource "aws_iam_instance_profile" "assets_iam_profile" {
  name = "${var.app_prefix}-assets-profile"
  role = aws_iam_role.assets_role.name

  tags = {
    Customer    = "${var.customer}"
    Environment = "${var.environment}"
  }

}

resource "aws_iam_role" "assets_role" {
  name = "${var.app_prefix}-asset-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    Customer    = "${var.customer}"
    Environment = "${var.environment}"
  }
}

resource "aws_iam_role_policy" assets_policy" {
  name = "${var.app_prefix}-assets-policy"
  role = aws_iam_role.assets_role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:*"
        ],
        "Effect": "Allow",
        "Resource": [
                "arn:aws:s3:::${var.app_prefix}-assets",
                "arn:aws:s3:::${var.app_prefix}-assets/*"
        ]
      }
    ]
  }
  EOF

  tags = {
    Customer    = "${var.customer}"
    Environment = "${var.environment}"
  }
}
