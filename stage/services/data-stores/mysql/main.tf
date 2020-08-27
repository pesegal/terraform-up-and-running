provider "aws" {
    region = "us-west-2"
}

terraform {
    backend "s3" {
        bucket = "terraform-state-pesegal"
        key = "stage/services/data-stores/terraform.tfstate"
        region = "us-west-2"

        # Replace this with the DynamoDB table name!
        dynamodb_table = "terraform-state-locks-pesegal"
        encrypt = true
    }
}

resource "aws_db_instance" "example" {
    identifier_prefix = "terraform-up-and-running"
    engine            = "mysql"
    allocated_storage = 10
    instance_class    = "db.t2.micro"
    name              = "example_database"
    username          = "admin"

    password = var.db_password
}



