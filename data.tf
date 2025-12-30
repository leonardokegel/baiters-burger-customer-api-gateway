data "terraform_remote_state" "ecs_infra" {
  backend = "s3"
  config = {
    bucket = "baiters-burger-customer-app"
    key    = "terraform/ecs/state.tfstate"
    region = "us-east-1"
  }
}