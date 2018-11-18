
output "sqs_queue_id" {
  value = "${aws_sqs_queue.s3_data_queue.id}"
}

