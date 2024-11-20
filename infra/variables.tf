variable "aws_region" {
  default = "eu-west-1"
  description = "AWS Region to deploy resources"
}

variable "my_role_arn" {
  description = "my created role"
  type        = string
  default = "arn:aws:iam::244530008913:role/labda_sqs_s3_exam_59"
}