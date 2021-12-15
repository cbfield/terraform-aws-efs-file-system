output "access_points" {
  description = "Access points created for this file system"
  value       = aws_efs_access_point.access_point
}

output "availability_zone_name" {
  description = "The value provided for var.availability_zone_name"
  value       = var.availability_zone_name
}

output "creation_token" {
  description = "The value provided for var.creation_token"
  value       = var.creation_token
}

output "encrypted" {
  description = "The value provided for var.encrypted"
  value       = var.encrypted
}

output "file_system" {
  description = "The file system created by this module"
  value       = aws_efs_file_system.file_system
}

output "kms_key_id" {
  description = "The value provided for var.kms_key_id"
  value       = var.kms_key_id
}

output "performance_mode" {
  description = "The value provided for var.performance_mode"
  value       = var.performance_mode
}

output "provisioned_throughput_in_mibps" {
  description = "The value provided for var.provisioned_throughput_in_mibps"
  value       = var.provisioned_throughput_in_mibps
}

output "throughput_mode" {
  description = "The value provided for var.throughput_mode"
  value       = var.throughput_mode
}

output "lifecycle_policy" {
  description = "The value provided for var.lifecycle_policy"
  value       = var.lifecycle_policy
}

output "tags" {
  description = "Tags assigned to the file system"
  value = merge(var.tags, {
    "Managed By Terraform" = "true"
  })
}
