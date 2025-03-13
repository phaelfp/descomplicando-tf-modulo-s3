module "backend" {
  source         = "../"
  aws_region     = var.aws_region
  s3_bucket_name = var.s3_bucket_name
}

output "backend_s3" {
  value = module.backend.s3_bucket_name
}