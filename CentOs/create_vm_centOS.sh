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
  --initrd-inject ks.cfg \
  --extra-args "inst.ks=file:ks.cfg console=ttyS0,115200" \
  --graphics none\
  --os-variant rhel9.0 \
  --console pty,target_type=serial \