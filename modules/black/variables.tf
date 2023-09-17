variable "region" {
  description = "AWS Region"
  type        = string
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "availability_zone" {
  description = "Subnet AZ"
  type        = string
}

variable "python_script_path" {
  description = "Path to the python script to be set as a lambda function"
  type        = string
  default     = "lambda.zip"
}

variable "ps_script_path" {
  description = "Path to the power shell script to be set as a startup script"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

variable "default_ami" {
  description = "Default AMI"
  type        = string
  default     = "ami-0ccf0745a25b6c3a4" # Winows Server 2022 base
}

variable "ssh_key" {
  type = string
}
