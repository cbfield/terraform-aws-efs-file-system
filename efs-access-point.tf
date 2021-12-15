resource "aws_efs_access_point" "access_point" {
  for_each = { for ap in var.access_points : ap.name => ap }

  file_system_id = aws_efs_file_system.file_system.id

  dynamic "posix_user" {
    for_each = each.value.posix_user != null ? [1] : []
    content {
      gid            = each.value.posix_user.gid
      secondary_gids = each.value.posix_user.secondary_gids
      uid            = each.value.posix_user.uid
    }
  }

  dynamic "root_directory" {
    for_each = each.value.root_directory != null ? [1] : []
    content {
      path = each.value.root_directory.path
      dynamic "creation_info" {
        for_each = each.value.root_directory.creation_info != null ? [1] : []
        content {
          owner_gid   = each.value.root_directory.creation_info.owner_gid
          owner_uid   = each.value.root_directory.creation_info.owner_uid
          permissions = each.value.root_directory.creation_info.permissions
        }
      }
    }
  }

  tags = merge(each.value.tags, {
    "Managed By Terraform" = "true",
    "Name"                 = each.value.name
  })
}
