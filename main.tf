module "example" {
  source = "./modules/black"

  region            = "eu-central-1" 
  availability_zone = "eu-central-1a"
  ssh_key           = "./public.pem"
  ps_script_path    = "./startup.ps1"
  aws_access_key    = "AKIAGGBESDCSDFSDSDSD" # Example key
  aws_secret_key    = "CmkasdmAKssdmk123KSD/ASDC55fsd/iR5" # Example key
}
