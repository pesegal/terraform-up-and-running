provider "aws" {
  region = "us-west-2"
}

module "webserver_cluster" {
    source = "../../../modules/services/webserver-cluster"

    cluster_name = "webservers-prod"
    db_remote_state_bucket = "terraform-state-pesegal"
    db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"
}