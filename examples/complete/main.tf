module "my_file_system" {
  source = "../../"

  # totally optional, but a random name will be generated if one is not provided
  name = "my-file-system"

  # The default vpc for the current region will be used if this value is omitted
  vpc_id = "vpc-123123"

  # This will make a dedicated key to encrypt the stuff in this file system
  create_kms_key = true

  # This will use some other key that you provide here
  # kms_key_id = "arn:..."

  # true by default
  encrypted = true

  # omit to make a regional file system, include to make a one-zone file system
  availability_zone_name = "us-east-1a"

  # "ENABLED" by default
  backup_policy = "DISABLED"

  file_system_policy = {
    bypass_policy_lockout_safety_check = false
    policy                             = ""
  }

  # "generalPurpose" by default
  performance_mode = "maxIO"

  # "bursting" by default
  throughput_mode = "provisioned"

  # only for when var.throughput_mode == "provisioned"
  provisioned_throughput_in_mibps = 1024

  lifecycle_policy = {
    transitiontransition_to_ia                    = "AFTER_7_DAYS"
    transitiontransition_to_primary_storage_class = "AFTER_1_ACCESS"
  }

  security_group = {
    # true by default
    create = true
    ingress_rules = [
      {
        description = "Traffic from application 1"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description      = "Traffic from application 2"
        ipv6_cidr_blocks = ["::/0"]
      },
      {
        description       = "Traffic from application 3"
        security_group_id = "sg-123123"
      },
    ]
  }

  access_points = [
    {
      name = "application-1"
      posix_user = {
        gid = 1000
        uid = 1000
        secondary_gids = [
          1001,
          1002
        ]
      }
      root_directory = {
        path = "/application-1/"
        creation_info = {
          owner_gid   = 1000
          owner_uid   = 1000
          permissions = 700
        }
      }
    }
  ]

  mount_targets = [
    {
      subnet_id              = "subnet-123123"
      security_groups        = ["sg-123123"]
      inherit_security_group = false
    },
    {
      subnet_id  = "subnet-234234"
      ip_address = "10.10.10.10"
    }
  ]
}
