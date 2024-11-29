resource "aws_instance" "docker_server" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name = data.aws_key_pair.key.key_name
  security_groups = [aws_security_group.ssh_access.name]

  tags = {
    Name = "Docker-Server"
  }
}

resource "null_resource" "ansible" {
  # Trigger the null_resource when the instance ID changes
  triggers = {
    instance_id = aws_instance.docker_server.id
  }

  provisioner "local-exec" {
    command = "./provision-docker-host --user=ubuntu --ip='${aws_instance.docker_server.public_ip}'"
  }
}
