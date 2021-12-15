resource "aws_efs_mount_target" "mount_target" {
  for_each = { for mt in var.mount_targets : mt.ip_address != null ? (
    join(":", [mt.subnet_id, mt.ip_address])) : (
    mt.subnet_id
  ) => mt }

  file_system_id = aws_efs_file_system.file_system.id
  subnet_id      = each.value.subnet_id
  ip_address     = each.value.ip_address

  security_groups = coalesce(each.value.inherit_security_group, true) ? concat(
    coalesce(each.value.security_groups, []),
    coalesce(try(aws_security_group.security_group.0.id, null), [])
    ) : (
    coalesce(each.value.security_groups, [])
  )
}
