# Gentoo on Raspberry Pi Zero W

This repository contains configuration files and setup scripts for running Gentoo Linux on a Raspberry Pi Zero W with USB gadget mode enabled for both serial console and networking.

## Features
- USB Gadget mode enabled (serial console + ethernet)
- Static IP configuration (10.42.0.2)
- SSH enabled by default
- Default root password: gentoo

## Directory Structure
- `boot/` - Boot partition configuration files
  - `cmdline.txt` - Kernel command line parameters
  - `config.txt` - Raspberry Pi configuration
- `etc/` - System configuration files
  - `conf.d/` - OpenRC configuration
    - `net` - Network interface configuration
- `scripts/` - Helper scripts for setup and maintenance
  - `setup.sh` - Main setup script

## Setup Instructions

1. Flash the Gentoo stage3 tarball to your SD card
2. Clone this repository
3. Run the setup script:
   ```bash
   sudo ./scripts/setup.sh
   ```

## USB Gadget Mode
When connected via USB:
- Serial console: `/dev/ttyACM0` (115200 baud)
- Network: usb0 interface (Pi: 10.42.0.2, Host: 10.42.0.1)

## Connecting
1. Connect Pi Zero W via USB port (not PWR)
2. Monitor boot: `sudo screen /dev/ttyACM0 115200`
3. SSH access: `ssh root@10.42.0.2`

## Building Packages
The USB network interface allows you to compile packages on your host machine using distcc.
