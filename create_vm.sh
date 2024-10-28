#!/bin/bash

# Variables
VM_NAME="archlinux-vm"
MEMORY="1024"
CPUS="2"
DISK_SIZE="10G"
ISO_PATH="/var/lib/libvirt/images/archlinux-2024.10.01-x86_64.iso"

# Créer un disque virtuel
qemu-img create -f qcow2 /var/lib/libvirt/images/${VM_NAME}.qcow2 ${DISK_SIZE}

# Créer la VM
virt-install \
  --name ${VM_NAME} \
  --memory ${MEMORY} \
  --vcpus ${CPUS} \
  --disk path=/var/lib/libvirt/images/${VM_NAME}.qcow2,format=qcow2 \
  --cdrom ${ISO_PATH} \
  --network bridge=virbr0 \
  --graphics vnc \
  --console pty,target_type=serial \
  --boot cdrom,hd
