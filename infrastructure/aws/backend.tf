terraform {
  backend "s3" {
    bucket = "infra"
    key    = "development"
    region = "us-east-2"
  }
}
