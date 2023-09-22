resource "aws_key_pair" "black_key_pair" {
  key_name   = "black_key_pair"
  public_key = file(var.ssh_key)
}

resource "aws_instance" "basic_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.black_key_pair.key_name
  subnet_id     = aws_subnet.black_subnet.id

  user_data = file(var.ps_script_path)

  tags = {
    Name = "BasicModuleInstance"
  }
}
