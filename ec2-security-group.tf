resource "aws_security_group" "security_group" {
  count = coalesce(try(var.security_group.create, null), true) ? 1 : 0

  description = "Manages access to the EFS ${aws_efs_file_system.file_system.id} (${lookup(aws_efs_file_system.file_system.tags, "Name")}))"
  name        = coalesce(var.name, try(random_pet.name.0.id, null))
  tags        = try(var.security_group.tags, null)
  vpc_id      = var.vpc_id
}

resource "aws_security_group_rule" "ingress" {
  for_each = { for rule in coalesce(try(var.security_group.ingress_rules, null), []) : coalesce(
    rule.security_group_id,
    join(":", coalesce(rule.cidr_blocks, [])),
    join(":", coalesce(rule.ipv6_cidr_blocks, []))
  ) => rule }

  description              = each.value.description
  type                     = "ingress"
  from_port                = 2049
  to_port                  = 2049
  protocol                 = "tcp"
  cidr_blocks              = each.value.cidr_blocks
  ipv6_cidr_blocks         = each.value.ipv6_cidr_blocks
  source_security_group_id = each.value.security_group_id
  security_group_id        = aws_security_group.security_group.0.id
}
