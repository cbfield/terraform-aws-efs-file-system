# terraform-aws-efs-file-system
A Terraform module that creates an AWS Elastic File System (EFS), with mount targets, access points, a security group, and a kms key to encrypt the file system contents

# Terraform Docs

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_efs_access_point.access_point](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point) | resource |
| [aws_efs_backup_policy.backup_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_backup_policy) | resource |
| [aws_efs_file_system.file_system](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system) | resource |
| [aws_efs_file_system_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_file_system_policy) | resource |
| [aws_efs_mount_target.mount_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_mount_target) | resource |
| [aws_kms_alias.alias](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_security_group.security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [random_pet.name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_points"></a> [access\_points](#input\_access\_points) | Access points into this file system | <pre>list(object({<br>    name = string<br>    posix_user = optional(object({<br>      gid            = string<br>      secondary_gids = optional(list(string))<br>      uid            = string<br>    }))<br>    root_directory = optional(object({<br>      creation_info = optional(object({<br>        owner_gid   = number<br>        owner_uid   = number<br>        permissions = number<br>      }))<br>      path = optional(string)<br>    }))<br>    tags = optional(map(string))<br>  }))</pre> | `[]` | no |
| <a name="input_availability_zone_name"></a> [availability\_zone\_name](#input\_availability\_zone\_name) | If creating a one-zone file system, the availability zone to place it in | `string` | `null` | no |
| <a name="input_backup_policy"></a> [backup\_policy](#input\_backup\_policy) | 'ENABLED' or 'DISABLED' | `string` | `"ENABLED"` | no |
| <a name="input_create_kms_key"></a> [create\_kms\_key](#input\_create\_kms\_key) | If true, a KMS key will be created to encrypt the contents of this file system | `bool` | `false` | no |
| <a name="input_creation_token"></a> [creation\_token](#input\_creation\_token) | A unique token used to ensure idempotent file system creation | `string` | `null` | no |
| <a name="input_encrypted"></a> [encrypted](#input\_encrypted) | Whether or not to encrypt the contents of the file system | `bool` | `true` | no |
| <a name="input_file_system_policy"></a> [file\_system\_policy](#input\_file\_system\_policy) | An IAM resource policy to assign to the file system | <pre>object({<br>    bypass_policy_lockout_safety_check = optional(bool)<br>    policy                             = string<br>  })</pre> | `null` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN of a KMS key to use to encrypt the file system. var.encrypted must be true to specify this | `string` | `null` | no |
| <a name="input_lifecycle_policy"></a> [lifecycle\_policy](#input\_lifecycle\_policy) | Lifecycle policy attributes for files in this file system | <pre>object({<br>    transition_to_ia                    = optional(string)<br>    transition_to_primary_storage_class = optional(string)<br>  })</pre> | `null` | no |
| <a name="input_mount_targets"></a> [mount\_targets](#input\_mount\_targets) | Mount targets to create on this file sysytem | <pre>list(object({<br>    ip_address             = optional(string)<br>    inherit_security_group = optional(bool)<br>    security_groups        = optional(list(string))<br>    subnet_id              = string<br>  }))</pre> | `[]` | no |
| <a name="input_name"></a> [name](#input\_name) | A name to assign to the file system | `string` | `null` | no |
| <a name="input_performance_mode"></a> [performance\_mode](#input\_performance\_mode) | 'generalPurpose' or 'maxIO' | `string` | `"generalPurpose"` | no |
| <a name="input_provisioned_throughput_in_mibps"></a> [provisioned\_throughput\_in\_mibps](#input\_provisioned\_throughput\_in\_mibps) | If var.throughput\_mode is 'provisioned', this specifies the troughput allowed, in MiB/s | `number` | `null` | no |
| <a name="input_security_group"></a> [security\_group](#input\_security\_group) | Configurations for the security group created for this file system | <pre>object({<br>    create = optional(bool)<br>    ingress_rules = optional(list(object({<br>      description       = optional(string)<br>      cidr_blocks       = optional(list(string))<br>      ipv6_cidr_blocks  = optional(list(string))<br>      security_group_id = optional(string)<br>    })))<br>    tags = optional(map(string))<br>  })</pre> | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the file system | `map(string)` | `{}` | no |
| <a name="input_throughput_mode"></a> [throughput\_mode](#input\_throughput\_mode) | 'bursting' or 'provisioned' | `string` | `"bursting"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_points"></a> [access\_points](#output\_access\_points) | Access points created for this file system |
| <a name="output_availability_zone_name"></a> [availability\_zone\_name](#output\_availability\_zone\_name) | The value provided for var.availability\_zone\_name |
| <a name="output_backup_policy"></a> [backup\_policy](#output\_backup\_policy) | The backup policy for the file system |
| <a name="output_creation_token"></a> [creation\_token](#output\_creation\_token) | The value provided for var.creation\_token |
| <a name="output_encrypted"></a> [encrypted](#output\_encrypted) | The value provided for var.encrypted |
| <a name="output_file_system"></a> [file\_system](#output\_file\_system) | The file system created by this module |
| <a name="output_file_system_policy"></a> [file\_system\_policy](#output\_file\_system\_policy) | The file system resource policy |
| <a name="output_kms_key"></a> [kms\_key](#output\_kms\_key) | The KMS key created to encrypt te contents of the file system |
| <a name="output_kms_key_alias"></a> [kms\_key\_alias](#output\_kms\_key\_alias) | The alias of the KMS key created to encrypt te contents of the file system |
| <a name="output_kms_key_id"></a> [kms\_key\_id](#output\_kms\_key\_id) | The value provided for var.kms\_key\_id |
| <a name="output_lifecycle_policy"></a> [lifecycle\_policy](#output\_lifecycle\_policy) | The value provided for var.lifecycle\_policy |
| <a name="output_mount_targets"></a> [mount\_targets](#output\_mount\_targets) | Mount targets created for the file system |
| <a name="output_performance_mode"></a> [performance\_mode](#output\_performance\_mode) | The value provided for var.performance\_mode |
| <a name="output_provisioned_throughput_in_mibps"></a> [provisioned\_throughput\_in\_mibps](#output\_provisioned\_throughput\_in\_mibps) | The value provided for var.provisioned\_throughput\_in\_mibps |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags assigned to the file system |
| <a name="output_throughput_mode"></a> [throughput\_mode](#output\_throughput\_mode) | The value provided for var.throughput\_mode |
