resource "aws_dynamodb_table" "java_servlet_table" {
  name = "mmk-java-servlet-dyn-table"
  read_capacity = "20"
write_capacity = "20"
hash_key = "LockID"

ttl
{
  attribute_name="TimeToExist"
  enabled = false
}

attribute {
    name = "LockID"
    type = "S"
}

tags = {
    Name = "mmk-java-servlet-dyn-table"
    Account = "AWSLRN"
    "nbn:env:code" = "np"
    "nbn:focalPoint:applicationid" = "057"
}
}