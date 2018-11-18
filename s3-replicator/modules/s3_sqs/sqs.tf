
/**
*		https://www.terraform.io/docs/providers/aws/r/sqs_queue.html
*/

resource "aws_sqs_queue" "s3_data_queue" {
  name                      = "s3-data-queue"
  delay_seconds             = 10
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 4
 
  tags {
    Environment = "alpha"
  }
}


/**
*		https://www.terraform.io/docs/providers/aws/r/sqs_queue_policy.html
*/

resource "aws_sqs_queue_policy" "test" {
  queue_url = "${aws_sqs_queue.s3_data_queue.id}"
  policy = "${data.aws_iam_policy_document.sqs_upload.json}"
}

data "aws_iam_policy_document" "sqs_upload" {
  policy_id = "sqs"
  statement {
    actions = [
      "sqs:SendMessage",
    ]
    condition {
      test = "ArnEquals"
      variable = "aws:SourceArn"
      values = [
        "${aws_s3_bucket.data.arn}",
      ]
    }
    effect = "Allow"
    principals {
      type = "AWS"
      identifiers = ["*"]  
    }
    resources = [
      "${aws_sqs_queue.s3_data_queue.arn}",
    ]
    sid = "s3-sqs"
  }
}
