
variable "box_tag" {
  type    = string
  default = "voegelas/debian-ppc64"
}

variable "headless" {
  type    = string
  default = "true"
}

variable "version" {
  type    = string
  default = ""
}

variable "version_description" {
  type    = string
  default = ""
}

source "qemu" "debian-ppc64" {
  accelerator        = "tcg"
  cpus               = 1
  disk_detect_zeroes = "unmap"
  disk_discard       = "unmap"
  disk_image         = "true"
  disk_interface     = "virtio"
  disk_size          = "80G"
  format             = "qcow2"
  headless           = "${var.headless}"
  iso_checksum       = "sha256:c87d778aef90eeed3de0a9bc646ff33a58d468799ac9f0e49bb2c37c7201897a"
  iso_urls           = ["debian-ppc64.qcow2", "http://mirror.andreasvoegele.com/qemu/debian-ppc64.qcow2"]
  machine_type       = "pseries"
  memory             = 1024
  net_device         = "virtio-net"
  qemu_binary        = "qemu-system-ppc64"
  qemuargs           = [["-cpu", "power8"]]
  shutdown_command   = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_password       = "vagrant"
  ssh_timeout        = "30m"
  ssh_username       = "vagrant"
  vm_name            = "packer-debian-ppc64"
}

build {
  sources = ["source.qemu.debian-ppc64"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "scripts/setup.sh"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -S -E bash '{{ .Path }}'"
    script          = "scripts/cleanup.sh"
  }

  post-processors {
    post-processor "vagrant" {
      output = "builds/libvirt-debian-ppc64.box"
    }
    post-processor "vagrant-cloud" {
      box_tag             = "${var.box_tag}"
      version             = "${var.version}"
      version_description = "${var.version_description}"
    }
  }
}
