resource "harvester_virtualmachine" "ubuntu2004" {
  name                 = "ubuntu2004"
  namespace            = "default"
  restart_after_update = true

  description = "ubuntu2004 test vm"
  tags = {
    ssh-user = "ubuntu"
  }

  cpu    = 2
  memory = "2Gi"

  efi         = true
  secure_boot = true

  run_strategy = "RerunOnFailure"
  hostname     = "vm001"
  machine_type = "q35"

  network_interface {
    name           = "eth01"
    wait_for_lease = true
  }

  disk {
    name       = "rootdisk"
    type       = "disk"
    size       = "10Gi"
    bus        = "virtio"
    boot_order = 1

    image       = harvester_image.ubuntu2004.id
    auto_delete = true
  }

  disk {
    name        = "disk001"
    type        = "disk"
    size        = "2Gi"
    bus         = "virtio"
    auto_delete = true
  }

  cloudinit {
    user_data    = <<-EOF
      #cloud-config
      password: ubuntu
      chpasswd:
        expire: false
      ssh_pwauth: true
      package_update: true
      packages:
        - qemu-guest-agent
      runcmd:
        - - systemctl
          - enable
          - '--now'
          - qemu-guest-agent
      EOF
    network_data = ""
  }
}