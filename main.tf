module "black_envs" {

  source = "./modules/black"

  region            = var.config.region
  availability_zone = var.config.availability_zone
  ssh_key           = var.config.ssh_key
  ps_script_path    = var.config.ps_script_path
  ami_id            = var.config.ami_id
  aws_access_key    = var.config.aws_access_key
  aws_secret_key    = var.config.aws_secret_key
}
