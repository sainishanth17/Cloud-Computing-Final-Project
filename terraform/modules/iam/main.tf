
resource "aws_iam_policy" "ss-app-s3-policy" {
  name        = "ss-app-policy"
  description = "Allow access to S3 bucket"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "socials3policy",
        "Action" : [
          "s3:DeleteObject",
          "s3:GetObject",
          "s3:PutObject"
        ],
        "Effect" : "Allow",
        "Resource" : "${var.image-bucket-arn}/*"
      }
    ]
  })
}

resource "aws_iam_role" "ss-app-role" {
  name = "ss-app-role"

  # This is a role for EC2 instances
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ss-app-role-s3_policy_attachment" {
  role       = "${aws_iam_role.ss-app-role.name}"
  policy_arn = "${aws_iam_policy.ss-app-s3-policy.arn}"
}

resource "aws_iam_role_policy_attachment" "ss-app-role-cloudwatch_policy_attachment" {
  role       = "${aws_iam_role.ss-app-role.name}"
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ss-app-instance_profile" {
  name = "ss-app-instance_profile"
  role = "${aws_iam_role.ss-app-role.name}"
}