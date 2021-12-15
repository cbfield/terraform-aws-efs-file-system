variable "access_points" {
  description = "Access points into this file system"
  type = list(object({
    name = string
    posix_user = optional(object({
      gid            = string
      secondary_gids = optional(list(string))
      uid            = string
    }))
    root_directory = optional(object({
      creation_info = optional(object({
        owner_gid   = number
        owner_uid   = number
        permissions = number
      }))
      path = optional(string)
    }))
    tags = optional(map(string))
  }))
  default = []
}

variable "availability_zone_name" {
  description = "If creating a one-zone file system, the availability zone to place it in"
  type        = string
  default     = null
}

variable "backup_policy" {
  description = "'ENABLED' or 'DISABLED'"
  type        = string
  default     = "ENABLED"
  validation {
    condition     = contains(["ENABLED", "DISABLED"], var.backup_policy)
    error_message = "Only the values 'ENABLED' or 'DISABLED' are valid."
  }
}

variable "creation_token" {
  description = "A unique token used to ensure idempotent file system creation"
  type        = string
  default     = null
}

variable "encrypted" {
  description = "Whether or not to encrypt the contents of the file system"
  type        = bool
  default     = true
}

variable "file_system_policy" {
  description = "An IAM resource policy to assign to the file system"
  type = object({
    bypass_policy_lockout_safety_check = optional(bool)
    policy                             = string
  })
  default = null
}

variable "kms_key_id" {
  description = "The ARN of a KMS key to use to encrypt the file system. var.encrypted must be true to specify this"
  type        = string
  default     = null
}

variable "mount_targets" {
  description = "Mount targets to create on this file sysytem"
  type = list(object({
    ip_address             = optional(string)
    inherit_security_group = optional(bool)
    security_groups        = optional(list(string))
    subnet_id              = string
  }))
}

variable "performance_mode" {
  description = "'generalPurpose' or 'maxIO'"
  type        = string
  default     = "generalPurpose"
  validation {
    condition     = contains(["generalPurpose", "maxIO"], var.performance_mode)
    error_message = "Only the values 'generalPurpose' or 'maxIO' are valid."
  }
}

variable "provisioned_throughput_in_mibps" {
  description = "If var.throughput_mode is 'provisioned', this specifies the troughput allowed, in MiB/s"
  type        = number
  default     = null
}

variable "throughput_mode" {
  description = "'bursting' or 'provisioned'"
  type        = string
  default     = "bursting"
  validation {
    condition     = contains(["bursting", "provisioned"], var.throughput_mode)
    error_message = "Only the values 'bursting' or 'provisioned' are valid."
  }
}

variable "lifecycle_policy" {
  description = "Lifecycle policy attributes for files in this file system"
  type = object({
    transition_to_ia                    = optional(string)
    transition_to_primary_storage_class = optional(string)
  })
  default = {}
}

variable "name" {
  description = "A name to assign to the file system"
  type        = string
  default     = null
}

variable "security_group" {
  description = "Configurations for the security group created for this file system"
  type = object({
    create = optional(bool)
    ingress_rules = optional(list(object({
      description       = optional(string)
      cidr_blocks       = optional(list(string))
      ipv6_cidr_blocks  = optional(list(string))
      security_group_id = optional(string)
    })))
    tags = optional(map(string))
  })
  default = null
}

variable "tags" {
  description = "Tags to assign to the file system"
  type        = map(string)
  default     = {}
}
