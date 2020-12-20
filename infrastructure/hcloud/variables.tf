# Token Variable Definition
variable "hcloud_token" {}

# Name variable definition
  variable "name" {
  default = "development"
}

# Defining a variable source OS image for an instance
variable "image" {
  default = "ubuntu-18.04"
}

# Definition of an instance type variable depending on the choice of tariff
# cx11 is the smallest and cheapest (1 core, 2.0GB memory and 20GB disk
variable "server_type" {
  default = "cx11"
}

# Definition of the region in which the instance will be created
variable "location" {
  default = "nbg1"
}

# Determining the ssh key that will be added to the instance when creating
variable "public_key" {}
