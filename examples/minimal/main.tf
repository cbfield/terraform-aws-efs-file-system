module "my_file_system" {
  source = "../../"

  mount_targets = flatten([
    [
      for subnet in ["subnet-123", "subnet-234"] : {
        subnet_id       = subnet
        security_groups = ["sg-321321"]
      }
    ],
    [
      {
        subnet_id  = "subnet-345"
        ip_address = "10.10.10.10"
        security_groups = [
          "sg-123123",
          "sg-234234",
        ]
      }
    ]
  ])
}
