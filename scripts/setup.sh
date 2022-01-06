#!/bin/bash -eux

# Remove /var/log/journal.
rm -rf /var/log/journal

# Configure grub.
if grep -q '^GRUB_CMDLINE_LINUX_DEFAULT="[^"]*\<quiet\>[^"]*"' /etc/default/grub; then
  sed -i '/^GRUB_CMDLINE_LINUX_DEFAULT=/s/\<quiet\>//' /etc/default/grub
fi
if ! grep -q '^GRUB_CMDLINE_LINUX="[^"]*\<net.ifnames=0\>[^"]*"' /etc/default/grub; then
  sed -i 's/^\(GRUB_CMDLINE_LINUX="\)/\1net.ifnames=0 /' /etc/default/grub
fi
if [ -x /etc/grub.d/30_os-prober ]; then
  chmod -x /etc/grub.d/30_os-prober
fi

# Upgrade packages.
apt-get -y update && apt-get -y upgrade

# Add vagrant user to sudoers.
echo "vagrant ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vagrant
chmod 440 /etc/sudoers.d/vagrant

# Disable daily apt unattended updates.
echo 'APT::Periodic::Enable "0";' >> /etc/apt/apt.conf.d/10periodic
