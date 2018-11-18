# S3 Replicator

Base project to use lambda to copy files between S3 buckets.

### SQS

Initial module to create S3 bucket and link to SQS queue, (no SNS needed).

### Build

Create a terraform.tfvars with the name of the source S3 bucket e.g :

```
bucket = "this-data-bucket"
```
