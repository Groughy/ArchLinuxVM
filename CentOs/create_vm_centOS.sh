#!/bin/bash

source vars.sh

# Créer un disque virtuel
qemu-img create -f qcow2 /var/lib/libvirt/images/${VM_NAME}.qcow2 ${DISK_SIZE}

# Créer la VM

virt-install \
  --name ${VM_NAME} \
  --ram ${MEMORY} \
  --vcpus ${CPUS} \
  --disk path=/var/lib/libvirt/images/${VM_NAME}.qcow2,format=qcow2 \
  --location ${ISO_PATH} \
  --initrd-inject=/home/groughformation/Documents/ArchLinuxTest/CentOs/ks.cfg \
  --extra-args="ks=file:/home/groughformation/Documents/ArchLinuxTest/CentOs/ks.cfg console=tty0 console=ttyS0,115200" \
  --network network=default \
  --graphics vnc \
  --console pty,target_type=serial \
  --boot cdrom,hd,menu=on