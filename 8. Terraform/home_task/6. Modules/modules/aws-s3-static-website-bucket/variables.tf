# Input variable definitions

variable "bucket_name" {
  description = "Name of the s3 bucket. Must be unique."
  type = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type = map(string)
  default     = {
    Name    = "EC2 & S3 bucket site (Modules_Task)"
    Owner   = "DevOps Student"
    Project = "Modules_Task (L1 EPAM)"
    Terraform   = "true"
    Environment = "dev"
  }
}
