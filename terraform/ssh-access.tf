# Fetch my public IP
data "http" "my_public_ip" {
  url = "http://checkip.amazonaws.com/"
}

# Format as CIDR
locals {
  my_cidr = "${trimspace(data.http.my_public_ip.response_body)}/32"
}


resource "aws_security_group" "ssh_access" {
  name        = "ssh-access-group"
  description = "Allow SSH access from my IP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.my_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
