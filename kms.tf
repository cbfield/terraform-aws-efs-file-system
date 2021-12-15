resource "aws_kms_key" "key" {
  count = var.create_kms_key ? 1 : 0

  description         = "Encrypts the contents of the EFS file system '${coalesce(var.name, try(random_pet.name.0.id, null))}'"
  enable_key_rotation = true

  tags = {
    "Managed By Terraform" = "true"
  }
}

resource "aws_kms_alias" "alias" {
  count = var.create_kms_key ? 1 : 0

  name          = "alias/efs/${coalesce(var.name, try(random_pet.name.0.id, null))}"
  target_key_id = aws_kms_key.key.0.key_id
}
