#!/bin/bash

source vars.sh

# Créer un disque virtuel
qemu-img create -f qcow2 /var/lib/libvirt/images/${VM_NAME}.qcow2 ${DISK_SIZE}

# Copier le fichier de variables UEFI
cp /usr/share/OVMF/OVMF_VARS_4M.fd ${UEFI_VARS_PATH}

# Créer la VM
virt-install \
  --name ${VM_NAME} \
  --memory ${MEMORY} \
  --vcpus ${CPUS} \
  --disk path=/var/lib/libvirt/images/${VM_NAME}.qcow2,format=qcow2 \
  --disk path=${UEFI_VARS_PATH},format=raw \
  --cdrom ${ISO_PATH} \
  --network bridge=virbr0 \
  --graphics vnc \
  --console pty,target_type=serial \
  --boot cdrom,hd \
