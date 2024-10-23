packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ami-ubuntu" {
  ami_name      = var.image_id
  instance_type = var.instance_type
  region        = var.region
  source_ami_filter {
    filters = {
      name                = "${ var.ami_filters }"
      root-device-type    = "${ var.ami_filters }"
      virtualization-type = "${ var.ami_filters }"
    }

    most_recent = true
    owners      =  var.ami_owners
     ssh_username = var.ssh_username
  tags
  {
    Name      =  "${var.ssh_username}"
    Environment = "${var.ssh_username}"
    OS_Version = "${var.ssh_username}"
    Release    = "${var.ssh_username}"
    Created-by = "${var.ssh_username}"
  }
}
}


build {
  name    = "packer-ubuntu-ami-template"
  sources = [
    "source.amazon-ebs.ami-ubuntu"
  ]

   provisioner "shell" {
    inline = [
      "echo Installing Updates",
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
      "sudo apt-get install -y nginx"
    ]
  } 
  
 /* provisioner "file" {
   source      = var.source_file         # Path to the local file
   destination = var.destination_path    # Path on the build machine
 }

provisioner "shell" {
inline = [
    echo 'File copied successfully!' > fp_req.txt
  ] */
 
} 



