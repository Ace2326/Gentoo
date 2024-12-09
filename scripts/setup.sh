#!/bin/bash

# Setup script for Gentoo on Raspberry Pi Zero W
# This script helps set up the basic configuration for Gentoo on a Pi Zero W

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Create mount points
mkdir -p /mnt/gentoo
mkdir -p /mnt/gentoo/boot

# Mount partitions (assuming /dev/sda1 is boot and /dev/sda2 is root)
mount /dev/sda2 /mnt/gentoo
mount /dev/sda1 /mnt/gentoo/boot

# Copy configuration files
cp -r boot/* /mnt/gentoo/boot/
cp -r etc/* /mnt/gentoo/etc/

# Set up network interface
ln -sf /etc/init.d/net.lo /mnt/gentoo/etc/init.d/net.usb0
chroot /mnt/gentoo /bin/bash -c "rc-update add net.usb0 default"

# Set root password
echo "Setting root password to 'gentoo'"
chroot /mnt/gentoo /bin/bash -c "echo 'root:gentoo' | chpasswd"

# Enable SSH
chroot /mnt/gentoo /bin/bash -c "rc-update add sshd default"

# Sync and unmount
sync
umount /mnt/gentoo/boot
umount /mnt/gentoo

echo "Setup complete!"
