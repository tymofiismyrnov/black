locals {
  environments = {
    for env in var.env_list : env.region => {
      region            = env.region
      availability_zone = env.availability_zone
      ssh_key           = env.ssh_key
      ps_script_path    = env.ps_script_path
      ami_id            = env.ami_id
      aws_access_key    = env.aws_access_key
      aws_secret_key    = env.aws_secret_key
    }
  }
}

module "black_envs" {
  for_each = local.environments

  source = "./modules/black"

  region            = each.value.region
  availability_zone = each.value.availability_zone
  ssh_key           = each.value.ssh_key
  ps_script_path    = each.value.ps_script_path
  ami_id            = each.value.ami_id
  aws_access_key    = each.value.aws_access_key
  aws_secret_key    = each.value.aws_secret_key

}
