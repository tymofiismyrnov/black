variable "region" {
  description = "AWS Region"
  type        = string
}

variable "availability_zone" {
  description = "Subnet AZ"
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

variable "ami_id" {
  description = "Default AMI"
  type        = string
}

variable "ssh_key" {
  type = string
}
