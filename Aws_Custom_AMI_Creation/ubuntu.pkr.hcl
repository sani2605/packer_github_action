packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ami-ubuntu" {
  ami_name      = "${var.ami_name}"
  instance_type = "${var.instance_type}"
  region        = var.region

  source_ami_filter {
    filters = {
      name                = "${var.source_ami_filter_name}"
      root-device-type    = "${var.source_ami_filter_root_device_type}"
      virtualization-type = "${var.source_amisource_ami_filter_virtualization_type}"
      }
     most_recent = true
     owners  = "${var.ami_owners}" 
    }   
     ssh_username="${var.ssh_username}"
}



build {
  name    = "packer-ubuntu-ami-template"
  sources = ["source.amazon-ebs.ami-ubuntu"]

   provisioner "shell" {
    inline = [
      "echo Installing Updates",
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
      "sudo apt-get install -y nginx"
    ]
  } 
}




