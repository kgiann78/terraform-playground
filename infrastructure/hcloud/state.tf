terraform {
  backend "s3" {                          # Backend designation
  bucket = "hetzner-terraform"            # Bucket name
  key = "bucket/terraform.tfstate"        # Key
  region = "us-east-2"                    # Region
  encrypt = "true"                        # Encryption enabled
  }
}
