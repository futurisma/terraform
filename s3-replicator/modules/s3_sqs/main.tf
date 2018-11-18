/**
*		https://www.terraform.io/docs/providers/aws/r/s3_bucket.html
*/

resource "aws_s3_bucket" "data" {
  bucket = "${var.bucket}"
  acl    = "private"

  versioning {
    enabled = true
  }
}



/**
*	Send S3 events direct to SQS
*/
resource "aws_s3_bucket_notification" "s3_notification" {
  bucket = "${aws_s3_bucket.data.id}"

  queue {
    queue_arn     = "${aws_sqs_queue.s3_data_queue.arn}"
    events        = ["s3:ObjectCreated:*"]
    filter_suffix = ".json"
  }
}

