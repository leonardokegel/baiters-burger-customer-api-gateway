resource "aws_cognito_user_pool" "pool" {
  name = "baitersburger-customer-pool"
  auto_verified_attributes = []
  mfa_configuration        = "OFF"

  admin_create_user_config {
    allow_admin_create_user_only = true
  }

  tags = {
    Project = "baitersburger"
    Service = "customer"
  }
}

resource "aws_cognito_user_pool_domain" "domain" {
  domain       = var.cognito_domain_prefix
  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_resource_server" "resource" {
  identifier = "baitersburger-api"
  name       = "BaitersBurger API"
  user_pool_id = aws_cognito_user_pool.pool.id

  scope {
    scope_name        = "totem"
    scope_description = "Permission to totem operations"
  }
}

resource "aws_cognito_user_pool_client" "machine_client" {
  name         = "BaitersBurgerCustomerMachineClient"
  user_pool_id = aws_cognito_user_pool.pool.id

  generate_secret                      = true
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["client_credentials"]
  allowed_oauth_scopes = [
    "${aws_cognito_resource_server.resource.identifier}/totem",
  ]

  supported_identity_providers = ["COGNITO"]
}