#!/bin/bash
###########################################
# DEBUGGING
###########################################
# /bin/sh (usually is a sybolic link to bash)
# /usr/bin/bash
# /usr/bin/env bash
# Debugging: set -x
# set -x   # Print a trace of simple commands and their arguments
###########################################
# SCRIPT INFORMATION
###########################################
# Select the disk device and chose a label for the partition
# ptype=msdos for disks up to 2 TB. ptype=gpt for disks over 2 TB
disk='/dev/vdb'
label='extra_storage01'
ptype='msdos'

# Print a purpose message to the console 
echo -e "Creating LVM partition on ${disk}"

# print the current partition(s) state
parted ${disk} print
sleep 10

# ensure the device isn't mounted already
echo -e "[INFO]: Ensure device isn't mounted: ${disk}"
sudo umount "${disk}" 
sleep 5

# create a gpt ot msdos partition table (depending on $ptype variable defined above)
echo -e "Creating partition table on ${disk}"
parted -s -a optimal ${disk} mklabel ${ptype}
sleep 5

# create the partition, starting at 1MB which may be better
# with newer disks
echo -e "Creating LVM partition on ${disk}"
parted -s -a optimal -- ${disk} unit compact mkpart primary ext4 "1M" "100%" set 1 lvm on
sleep 5

# Make filesystem on the LVM partition
echo -e "Creating filesystem on the LVM partition: ${disk}1"
mkfs.ext4 -j -v -L "${label}" ${disk}1
echo "[INFO]: Done, Phase 1."

# Phase 2, lvm_expand_vg.sh