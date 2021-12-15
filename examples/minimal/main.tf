module "my_file_system" {
  source = "../../"

  access_points = [
    {
      name = "ap1"
      posix_user = {
        uid = 1000
        gid = 1000
      }
      root_directory = {
        path = "/something/"
        creation_info = {
          owner_gid   = 1000
          owner_uid   = 1000
          permissions = 700
        }
      }
    }
  ]
}
