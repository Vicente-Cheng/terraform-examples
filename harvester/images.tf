resource "harvester_image" "ubuntu2004" {
  name      = "ubuntu2004"
  namespace = "default"

  display_name = "ubuntu-20.04-server-cloudimg-amd64.img"
  source_type  = "download"
  url          = "http://cloud-images.ubuntu.com/releases/focal/release/ubuntu-20.04-server-cloudimg-amd64.img"
}
