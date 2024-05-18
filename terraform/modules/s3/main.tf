resource "aws_s3_bucket" "ss_image_bucket" {
  bucket        = var.bucket_name
  force_destroy = true
}
