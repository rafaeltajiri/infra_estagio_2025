output "rds_endpoint" {
  description = "Endpoint para conexão com o banco de dados"
  value       = module.rds.rds_endpoint
}

output "ec2_public_dns" {
  description = "DNS público das instâncias EC2 dos estagiários"
  value       = module.ec2.ec2_public_dns
}