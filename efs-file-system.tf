resource "aws_efs_file_system" "file_system" {
  availability_zone_name          = var.availability_zone_name
  creation_token                  = var.creation_token
  encrypted                       = var.encrypted
  kms_key_id                      = var.create_kms_key ? try(aws_kms_key.key.0.arn, null) : var.kms_key_id
  performance_mode                = var.performance_mode
  provisioned_throughput_in_mibps = var.provisioned_throughput_in_mibps
  throughput_mode                 = var.throughput_mode

  dynamic "lifecycle_policy" {
    for_each = var.lifecycle_policy != null ? [1] : []
    content {
      transition_to_ia                    = var.lifecycle_policy.transition_to_ia
      transition_to_primary_storage_class = var.lifecycle_policy.transition_to_primary_storage_class
    }
  }

  tags = merge(var.tags, {
    "Name" = coalesce(var.name, try(random_pet.name.0.id, null))
  })
}

resource "random_pet" "name" {
  count = var.name == null ? 1 : 0
}
