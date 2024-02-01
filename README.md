# packer-debian-ppc64

Build a big-endian PowerPC Vagrant box for libvirt and qemu-system-ppc64.

QEMU's PowerPC emulator isn't fast but useful for testing software for byte
order bugs.

## DEPENDENCIES

Requires [packer](https://www.packer.io/),
[vagrant](https://www.vagrantup.com/), [libvirt](https://libvirt.org/),
[vagrant-libvirt](https://github.com/vagrant-libvirt/vagrant-libvirt) and
[qemu-system-ppc](https://www.qemu.org/).

## USAGE

Customize the scripts in the "scripts" directory or add
[provisioners](https://www.packer.io/docs/provisioners) to
"box-config.pkr.hcl".

Set the environment variable VAGRANT_CLOUD_TOKEN to your [access
token](https://app.vagrantup.com/settings/security) for the Vagrant Cloud API.

Install the required plugins:

    packer init box-config.pkr.hcl

Build and publish your box:

    packer build \
      -var 'box_tag=myname/mybox-ppc64' \
      -var 'version=20240201' \
      -var 'version_description=My custom box' \
      box-config.pkr.hcl

Put the following settings into your Vagrantfile:

    Vagrant.configure('2') do |config|
      config.vm.box = 'myname/mybox-ppc64'
      config.vm.box_architecture = 'ppc64'
      config.vm.provider :libvirt do |v|
        v.driver = 'qemu'
        v.machine_arch = 'ppc64'
        v.machine_type = 'pseries'
        v.cpu_mode = 'custom'
        v.cpu_model = 'POWER8'
        v.video_type = 'vga'
        v.features = []
      end
    end

## LICENSE AND COPYRIGHT

Copyright (C) 2024 Andreas Vögele

This program is free software; you can redistribute and modify it under the
terms of the ISC license.
