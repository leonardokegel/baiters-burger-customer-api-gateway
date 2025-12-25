module "cognito" {
  source = "./cognito"
  cognito_domain_prefix = "baitersburger-customer-app"
}

module "lambda-authorizer" {
  source       = "./lambda-authorizer"
  user_pool_id = module.cognito.cognito_user_pool_id
  client_id    = module.cognito.cognito_machine_client_id
}