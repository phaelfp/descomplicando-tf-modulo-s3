# Projeto de Conclusão de Curso do Descomplicando Terraform

## Modulo de S3 (s3)

Este módulo é responsável por criar um S3 para o backend do terraform

A documentação do módulo gerada pelo terraform-docs se encontra [aqui](README.TF.md)

## Exemplo de uso

Tem um exemplo completo do uso no diretório exemple caso queira ir logo para a parte prática.

Precisamos da seguinte estrutura de arquivos.

```css
│── main.tf
│── provider.tf
│── variables.tf
│── outputs.tf
```

### provider.tf

```tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

```

### variavles.tf

```tf
variable "aws_region" {
  default = "us-east-1"
}

variable "s3_bucket_name" {
  default = "meu-terraform-backend"
}

```

Temos aqui 3 variáveis

- Uma para idendificar a região que o backet e o dynamodb serão criados.
- O nome do bucket, lembrando que este nome tem que ser único na AWS

### main.tf

```tf
module "backend" {
  source         = "../"
  aws_region     = var.aws_region
  s3_bucket_name = var.s3_bucket_name
}

output "backend_s3" {
  value = module.backend.s3_bucket_name
}

```

Este main.tf o source está apontando para a pasta raiz, mas se você estiver já utilizando o módulo em outro utilize o código abaixo que está apontando para o repositório git

```tf
module "backend" {
  source   = "github.com/phaelfp/descomplicando-tf-modulo-s3?ref=v1.0.0"
  aws_region     = var.aws_region
  s3_bucket_name = var.s3_bucket_name
}

output "backend_s3" {
  value = module.backend.s3_bucket_name
}

```

### output.tf

```tf
output "s3_bucket_name" {
  description = "Nome do bucket S3 criado"
  value       = module.backend.s3_bucket_name
}

```

### Execução

Tendo as chaves de acesso a AWS configuradas no terminal corretamente é só executar os comando abaixo.

```sh
terraform init
terraform plan -out tfplan
terraform apply "tfplan"
```
