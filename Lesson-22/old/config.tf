provider "aws" {
  region = "us-west-2" // Region where to Create Resources
}

terraform {
  backend "s3" {
    bucket = "lambda.create.me.on-1662893034.3455179"    // Bucket where to SAVE Terraform State
    key    = "old-all/terraform.tfstate" // Object name in the bucket to SAVE Terraform State
    region = "eu-west-1"                 // Region where bucket is created
  }
}