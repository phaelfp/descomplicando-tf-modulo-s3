output "s3_bucket_name" {
  description = "Nome do bucket S3 criado"
  value       = module.backend.s3_bucket_name
}