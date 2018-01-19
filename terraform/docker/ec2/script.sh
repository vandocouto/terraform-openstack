#!/usr/bin/env bash
# configure disk
sudo mkfs.ext4 /dev/sdb
sudo mkdir -p /var/lib/docker/volumes
sudo sed -i '$ a /dev/sdb /var/lib/docker/volumes ext4 defaults 0 0' /etc/fstab
sudo mount -a
sudo apt-get install python-simplejson -y