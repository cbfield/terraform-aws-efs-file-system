resource "aws_efs_backup_policy" "backup_policy" {
  file_system_id = aws_efs_file_system.file_system.id

  backup_policy {
    status = var.backup_policy
  }
}
