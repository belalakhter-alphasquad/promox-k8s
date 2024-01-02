#!/bin/bash

# Configuration parameters
VMID=100
VMNAME="ubuntu-server"
MEMORY=1048
DISK_SIZE="2G"
ISO_PATH="local-lvm:iso/ubuntu-20.04.1-live-server-amd64.iso"
STORAGE_POOL="local-lvm"
BRIDGE="vmbr0"

# Create a new VM
qm create $VMID --name $VMNAME --memory $MEMORY --net0 virtio,bridge=$BRIDGE

# Import the Ubuntu Server Disk Image
qm set $VMID --ide2 $ISO_PATH,media=cdrom

# Configure a Hard Disk for the VM
qm set $VMID --virtio0 $STORAGE_POOL:$DISK_SIZE

# Set Boot Options
qm set $VMID --boot c --bootdisk virtio0
qm set $VMID --boot order=ide2;virtio0

# Start the VM
qm start $VMID

echo "Ubuntu VM with ID $VMID is created and started."
echo "Please proceed with the installation via the Proxmox web interface or qm terminal."
