terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta2"
    }
  }
}

import {
    to = aws_s3_bucket.s3_existing
    id = "ps-tf-existing-bucket-9169b660"
}

resource "random_id" "s3_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "s3_existing" {
  bucket = "ps-tf-existing-bucket-9169b660"

  tags = {
    ManagedBy = "terraform"
  }
}

resource "aws_s3_bucket" "s3" {
  bucket = "ps-tf-bucket-${terraform.workspace}-${random_id.s3_suffix.hex}"

  tags = {
    ManagedBy   = "terraform"
    Environment = terraform.workspace
  }
}
