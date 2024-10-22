variable "image_id" {
  type    = string
  default = "packer-ubuntu-custome-image-{{timestamp}}"

validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "The image_id value must be a valid AMI ID, starting with \"ami-\"."
  }
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}


variable "region" {
  type    = list(string)
  default = ["us-east-1"]
}

variable "ami_filters" {
  type = map(string)
  default = {
    name                = "ubuntu-pro-server/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-pro-server-20240913"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
}

variable "ami_owners" {
  type    = list(string)
  default = ["099720109477"]
}

variable "ssh_username" {
  type    = map(string)
  default {
    Name      = "MyUbuntuImage"
    Environment = "Production"
    OS_Version = "Ubuntu 22.04"
    Release    = "Latest"
    Created-by = "Packer"
  }
  }

variable "source_file" {
  description = "The file to copy to the build machine"
  type        = string
  source=. /fp_req.txt
}

variable "destination_path" {
  description = "The destination path on the build machine"
  type        = string
  destination=/tmp/fp_req.txt
}