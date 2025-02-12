terraform {
  backend "s3" {
    bucket   = "campaigns-terraform-state-demo1"
    region   = "us-west-2"
    key      = "terraform.tfstate"
  }
}
