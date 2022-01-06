# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false
  config.vm.synced_folder '.', '/vagrant', type: 'nfs', nfs_udp: false

  # libvirt.
  config.vm.define "libvirt" do |libvirt|
    libvirt.vm.hostname = "libvirt-debian-ppc64"
    libvirt.vm.box = "file://builds/libvirt-debian-ppc64.box"

    config.vm.provider :libvirt do |v|
      v.driver = "qemu"
      v.machine_arch = "ppc64"
      v.machine_type = "pseries"
      v.cpu_mode = "custom"
      v.cpu_model = "POWER8"
      v.video_type = "vga"
    end

    config.vm.provision "shell", inline: "echo Hello, World"
  end
end
