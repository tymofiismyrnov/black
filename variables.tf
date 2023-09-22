variable "config" {
  description = "Environment config"
  type = object({
    region            = string
    availability_zone = string
    ssh_key           = string
    ps_script_path    = string
    ami_id            = string
    aws_access_key    = string
    aws_secret_key    = string
  })
  default = {
    region            = null
    availability_zone = null
    ssh_key           = "./public.pub"
    ps_script_path    = "./startup.ps1"
    ami_id            = null
    aws_access_key    = null
    aws_secret_key    = null
  }
}
