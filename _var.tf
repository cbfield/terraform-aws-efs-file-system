variable "availability_zone_name" {
  description = "If creating a one-zone file system, the availability zone to place it in"
  type        = string
  default     = null
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

variable "kms_key_id" {
  description = "The ARN of a KMS key to use to encrypt the file system. var.encrypted must be true to specify this"
  type        = string
  default     = null
}

variable "performance_mode" {
  description = "'generalPurpose' or 'maxIO'"
  type        = string
  default     = null
}

variable "provisioned_throughput_in_mibps" {
  description = "If var.throughput_mode is 'provisioned', this specifies the troughput allowed, in MiB/s"
  type        = number
  default     = null
}

variable "throughput_mode" {
  description = "'bursting' or 'provisioned'"
  type        = string
  default     = null
}

variable "lifecycle_policy" {
  description = "Lifecycle policy attributes for files in this file system"
  type = object({
    transition_to_ia                    = optional(string)
    transition_to_primary_storage_class = optional(string)
  })
  default = {}
}

variable "tags" {
  description = "Tags to assign to the file system"
  type        = map(string)
  default     = {}
}
