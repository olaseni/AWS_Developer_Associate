resource "aws_instance" "app_server" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  key_name = data.aws_key_pair.key.key_name

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
