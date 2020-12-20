variable "region" {
  default = "us-east-2"
}

variable "access_key" {
}

variable "secret_key" {
}

provider "aws" {
  version    = "~> 2.0"
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "template" {
  version    = "~> 2.1"
}

