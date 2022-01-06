#!/bin/bash -eux

# Apt cleanup.
apt-get autoremove -y
apt-get clean

#  Blank netplan machine-id (DUID) so machines get unique ID generated on boot.
:> /etc/machine-id
rm -f /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id

# Delete unneeded files.
rm -f /home/vagrant/*.sh

# Trim filesystems to free space.
fstrim -av
