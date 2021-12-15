resource "aws_efs_file_system_policy" "policy" {
  count = var.file_system_policy != null ? 1 : 0

  file_system_id                     = aws_efs_file_system.file_system.id
  bypass_policy_lockout_safety_check = var.file_system_policy.bypass_policy_lockout_safety_check
  policy                             = var.file_system_policy.policy
}
