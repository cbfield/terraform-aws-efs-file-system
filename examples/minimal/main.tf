module "my_file_system" {
  source = "../../"

  security_group = {
    ingress_rules = [
      { cidr_blocks = ["10.0.0.0/16"] },
      { security_group_id = "sg-123123" }
    ]
  }

  mount_targets = [
    for subnet in ["subnet-321321", "subnet-543543"] : {
      subnet_id       = subnet
      security_groups = ["sg-456456"]
    }
  ]
}
