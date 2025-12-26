module "cognito" {
  source                = "./cognito"
  cognito_domain_prefix = "baitersburger-customer-app"
}

module "lambda-authorizer" {
  source       = "./lambda-authorizer"
  user_pool_id = module.cognito.cognito_user_pool_id
  client_id    = module.cognito.cognito_machine_client_id
}

module "api_gateway" {
  source                       = "./api-gateway/infra"
  authorizer_lambda_invoke_arn = module.lambda-authorizer.authorizer_lambda_invoke_arn
  app_service_url              = data.terraform_remote_state.ecs_infra.outputs.nlb_dns_name
  vpc_link_id                  = data.terraform_remote_state.ecs_infra.outputs.vpc_link_id
}