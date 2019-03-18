resource "aws_s3_bucket" "java_servlet_bucket" {
  bucket = "mmk-java-servlet-backend"
  acl = ""
    versioning {
    enabled = true
  }
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = "Java Servlet bucket"
    AWS_account = "AWSLRN"
  }
}