variable "instance_type" {
  default = "t2.medium"
}

variable "docker_data_device_suffix" {
  default = "b"
}

variable "system_admin_public_key" {}

locals {
  tags = {
    "infra:stack" = "development:system"
  }
}

data "aws_ami" "ubuntu_lts" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "provision_disk_docker_data" {
  template      = "${file("cloud-init/provision-disk.yml")}"
  vars = {
    volume_path = "/dev/xvd${var.docker_data_device_suffix}"
    mount_point = "/var/lib/docker"
  }
}

data "template_cloudinit_config" "system_swarm_manager_cloud_init" {
  gzip = false
  base64_encode = false

  part {
    content_type = "text/cloud-config"
    content      = data.template_file.provision_disk_docker_data.rendered
  }

  part {
    content_type = "text/cloud-config"
    content      = file("cloud-init/install-docker.yml")
  }
}

resource "aws_key_pair" "system_admin_public_key" {
  key_name   = "system_admin_public_key"
  public_key = var.system_admin_public_key
}

resource "aws_instance" "development_system_swarm_manager" {
  ami                         = data.aws_ami.ubuntu_lts.id
  instance_type               = var.instance_type
  user_data                   = data.template_cloudinit_config.system_swarm_manager_cloud_init.rendered
  key_name                    = aws_key_pair.system_admin_public_key.key_name
  subnet_id                   = aws_subnet.development_system_subnet.id
  vpc_security_group_ids      = [
    aws_security_group.development_system_allow_ssh.id,
    aws_security_group.development_system_allow_http.id,
    aws_security_group.development_system_allow_https.id,
  ]
  ebs_block_device {
    device_name = "/dev/sd${var.docker_data_device_suffix}"
    volume_size = 100
  }
  tags = local.tags
}

output "system_swarm_manager_eip" {
  value = "Connect by running: ssh ubuntu@${aws_eip.development_system_swarm_manager_eip.public_ip}"
}
