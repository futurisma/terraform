module "s3_sqs" {
  source = "modules/s3_sqs"

  bucket = "${var.bucket}"
  
}
