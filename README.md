# Baiters Burger - Customer API Gateway

Este repositório contém as definições de infraestrutura para o **API Gateway** e o mecanismo de **Autenticação** (Cognito + Lambda Authorizer) do ecossistema Baiters Burger. A solução é provisionada na AWS utilizando Terraform.

## 🏗️ Visão Geral da Arquitetura

O gateway atua como o ponto único de entrada para as requisições de clientes, integrando os seguintes componentes:

### 1. Amazon API Gateway (REST)
* **Interface:** Define recursos e métodos baseados na especificação OpenAPI 3.0.
* **Integração:** Encaminha requisições autenticadas para o microserviço de clientes (Customer API) rodando no ECS.
* **Documentação:** A definição completa da API, incluindo esquemas de `Customer` e `CustomerInput`, está disponível na pasta `open-api`.

### 2. Autenticação (Amazon Cognito)
* **User Pool:** Gerencia o diretório de usuários para o sistema Baiters Burger.
* **Client:** Configurado para permitir fluxos de autenticação de usuários.

### 3. Lambda Authorizer
* **Função:** Uma função Node.js que valida os tokens JWT emitidos pelo Cognito antes de permitir o acesso aos recursos do API Gateway.
* **Segurança:** Utiliza a biblioteca `aws-jwt-verify` para validar a assinatura, o emissor e a expiração do token.

## 🛠️ Tecnologias Utilizadas

* **Terraform:** Para provisionamento de infraestrutura (Providers: AWS, Archive).
* **Node.js:** Runtime para a função Lambda do Authorizer.
* **OpenAPI/Swagger:** Para definição e documentação do contrato da API.

## 📂 Estrutura do Repositório

* **/api-gateway**: Contém as definições de infraestrutura do gateway e os arquivos de especificação OpenAPI.
* **/cognito**: Módulo Terraform para criação do User Pool e configurações de identidade.
* **/lambda-authorizer**: Infraestrutura para a função Lambda de autorização.
* **/lambda**: Código fonte em JavaScript (Node.js) do autorizador.

## 🚀 Pipeline de CI/CD

O repositório utiliza **GitHub Actions** para automação do deploy:

1.  **Checkout & AWS Auth:** Configura o ambiente com segredos da AWS.
2.  **Terraform Workflow:**
    * `terraform init`: Inicializa o backend (armazenado em S3).
    * `terraform validate`: Valida a sintaxe dos arquivos `.tf`.
    * `terraform plan`: Gera o plano de execução.
    * `terraform apply`: Aplica as mudanças automaticamente na branch `main`.

## 📊 Outputs Principais

Após o deploy, o Terraform disponibiliza informações cruciais para o consumo da API:
* **`api_gateway_url`**: O endpoint público para acesso à API.
* **`cognito_client_id`**: O ID do cliente de aplicação para autenticação.
