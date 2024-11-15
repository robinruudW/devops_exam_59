variable "region" {
  default = "eu-west-1"
}

variable "bucket_name" {
  default = "pgr301-couch-explorers"
}

variable "sqs_queue_name" {
  default = "image-generation-queue"
}