terraform {
    backend "s3" {
        bucket = "terraform-state-pesegal"
        key = "workspaces-example/terraform.tfstate"
        region = "us-west-2"

        # Replace this with the DynamoDB table name!
        dynamodb_table = "terraform-state-locks-pesegal"
        encrypt = true
    }
}


resource "aws_instance" "example" {
    ami = "ami-0ba8629bff503c084"
    instance_type = "t2.micro"
}