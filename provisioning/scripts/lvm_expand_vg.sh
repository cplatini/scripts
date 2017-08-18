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
disk_mapper_dir='/dev/mapper/vg1-lv_varlog'

# Add Logical Volume to existing VG
echo -e "Extend existing VG to the new LV: ${disk}1"
vgextend vg1 ${disk}1

# Extend dev mapper to consume the new space 
echo -e "Extend the logical volume."
lvextend -l +100%FREE ${disk_mapper_dir}

# Resize the filesystem
echo -e "Resize the filesystem."
resize2fs ${disk_mapper_dir}
echo "[INFO]: Done, Phase 2."