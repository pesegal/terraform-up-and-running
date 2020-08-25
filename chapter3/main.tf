provider "aws" {
    region = "us-west-2"
}

terraform {
    backend "s3" {
        bucket = "terraform-state-pesegal"
        key = "global/s3/terraform.tfstate"
        region = "us-west-2"

        # Replace this with the DynamoDB table name!
        dynamodb_table = "terraform-state-locks-pesegal"
        encrypt = true
    }
}

output "s3_bucket_arn" {
    value = aws_s3_bucket.terraform_state.arn
    description = "ARN of the S3 bucket"
}

output "dynamodb_table_name" {
    value = aws_dynamodb_table.terraform_locks.name
    description = "The name of the DynamoDB table"
}

resource "aws_s3_bucket" "terraform_state" {
    bucket = "terraform-state-pesegal"

    # Prevent accidental deletion of this s3 bucket
    lifecycle {
        prevent_destroy = true
    }

    # Enable versioning so we can see the full revision history of our
    # state files
    versioning {
        enabled = true
    }

    # Enable server side encyption by default
    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }

}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "terraform-state-locks-pesegal"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }

}