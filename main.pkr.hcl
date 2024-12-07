packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

source "amazon-ebs" "demo" {
  region        = "us-east-1"
  source_ami    = "ami-0e2c8caa4b6378d8c"
  instance_type = "t2.micro"
  ssh_username  = "t2.micro"
  ami_name      = "packer-test-ami-rohit-bhai"
}

build {
  sources = ["source.amazon-ebs.demo"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "sudo ufw allow 'Nginx HTTP'"
    ]
  }
}
