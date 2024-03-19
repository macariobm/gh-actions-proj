terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}


provider "aws" {
  region     = AWS_REGION #hard-coded to sa-east-1
  access_key = "${AWS_ACCESS_KEY_ID}"
  secret_key = "${AWS_SECRET_ACCESS_KEY}"

}
