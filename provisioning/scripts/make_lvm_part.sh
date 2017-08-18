#!/bin/bash
###########################################
# DEBUGGING
###########################################
# /bin/sh (usually is a symbolic link to bash)
# /usr/bin/bash
# /usr/bin/env bash
# Debugging: set -x
# set -x   # Print a trace of simple commands and their arguments
###########################################
# SCRIPT INFORMATION
# Example: 
# make_lvm_part.sh -d vdb -p msdos -m /dev/mapper/vg1-lv_varlog
###########################################
t_dev='/dev/'
t_DISK_DEV="${t_DISK_DEV:=}"
t_DISK_LABEL="${t_DISK_LABEL:=extra_storage_01}"
t_DISK_PTYPE="${t_DISK_PTYPE:=}"
t_LVM_GROUP="${t_LVM_GROUP:=}"
t_LVM_DEV_MAPPER_DIR="${t_LVM_DEV_MAPPER_DIR:=}"
###########################################
# SCRIPT VERSION & EDITS
###########################################
s_build_date='[Thu Jul 16 10:37:54 MDT 2015]'
s_build_update='[Fri Jul 17 18:22:33 UTC 2015]' # Change me, if changes are made
s_org='3M HIS, Cloud Hosting Operations'
s_author='Nicholas M. Houle'; # Add name ", name" when changes are made
s_version='1.2.3'
###########################################
# FUNCTION: version_info
# DESCRIPTION: echo the script version
###########################################
version_info() { 
cat <<__SCRIPTVERSION__

Script: $0

${s_org}
Author: ${s_author}
Version: ${s_version}, ${s_build_update}

__SCRIPTVERSION__

  # Version, exit
  exit $?
}
###########################################
# FUNCTION: usage_info
# DESCRIPTION: echo the script usage_info
###########################################
usage_info() { 
cat <<__SCRIPTUSAGE__

 Make LVM Partition: It's possible to invoke this script with command-line arguments.

    Example: $0 -d [Device] -p [Partition Type] -g [LVM group] -m [LVM Dev Mapper Name]

    Options:

        Device: (WARNING: Do not use root's volume.)
            vdb, other

        Partition Type: (msdos for disks up to 2 TB, gpt for disks over 2 TB)
            msdos, gpt


 WARNING: This script will erase the data on the device, so please use caution.

__SCRIPTUSAGE__

  exit $?
}
###########################################
# FUNCTION: is_empty
# DESCRIPTION: Check value is empty 
# Parameters: 
#   $1 = value to check
###########################################
function is_empty() {
  t_param=$1
  t_param="$(echo -e "${t_param}" | xargs)"
  # Check value is not empty and a number
  if [[ -z "${t_param}" ]]; then
      # return 0, is empty
      return 0
  fi
  # return 1, not empty
  return 1
}
###########################################
# FUNCTION: is_empty
# DESCRIPTION: Check value is empty 
# Parameters: 
#   $1 = value to check
###########################################
function is_root() {
t_param=$1
r_param=$2
t_param="$(echo -e "${t_param}" | xargs)"
r_param="$(echo -e "${r_param}" | xargs)"

	# Check values are empty
	if ( is_empty "${t_param}" ) || ( is_empty "${r_param}" ); then
		echo -e "[ERROR]: Couldn't determine root's values. [ Failed ]"
	    return 0
	fi

	# Check value is equal to root
	if [[ "${t_param}" == "${t_LVM_DEV_MAPPER_DIR}" ]]; then
		echo -e "[EXIT]: ${t_param} == ${t_LVM_DEV_MAPPER_DIR}"
		# return 0, matches root
		return 0
	fi

	# Check value is equal to root
	if ( printf "%s" "${t_DISK_DEV}" | grep -E '^sda$' > /dev/null 2>&1 ) || ( printf "%s" "${t_DISK_DEV}" | grep -E '^sda.$' > /dev/null 2>&1 ); then
		echo -e "[EXIT]: ${r_param} contains 'sda'"
	    # return 0, matches root
		return 0
	fi

	# Check value is equal to root
	if [[ "sda1" == "${t_DISK_DEV}" ]]; then
		echo -e "[EXIT]: ${r_param} == ${t_DISK_DEV}"
		# return 0, matches root
		return 0
	fi

	# Check value is equal to root
	if [[ "${r_param}" == "${t_DISK_DEV}" ]]; then
		echo -e "[EXIT]: ${r_param} == ${t_DISK_DEV}"
		# return 0, matches root
		return 0
	fi

  # return 1, not root
  return 1
}
###########################################
# DESCRIPTION: CHECK, VALIDATE, SET OPTIONS
# getopts: init (param, param)
# Must have all command-line options, except -v
###########################################
while getopts ":vd:p:g:m:" o; do
    case "${o}" in
        v)
            # -v is used for version information
            version_info
            ;;
        d)
            # Get the API Name
            t_DISK_DEV="${OPTARG}"
            while [ -z "${t_DISK_DEV}" ]; do
                # echo "(volume) VM volume: "
                read -p "Dev Name, -d [devname]: " t_DISK_DEV;
            done
            ;;

        p)
            # Get the VM Host Name
            t_DISK_PTYPE="${OPTARG}"
            while [ -z "${t_DISK_PTYPE}" ]; do
                # echo "(mapper) Device Mapper Name: "
                read -p "Device Partition Type, -p [partitiontype]: " t_DISK_PTYPE;
            done
            ;;
        g)
            # Get the VM Host Name
            t_LVM_GROUP="${OPTARG}"
            while [ -z "${t_LVM_GROUP}" ]; do
                # echo "(lvmgroup) Device Mapper Name: "
                read -p "LVM Group, -g [lvmgroup]: " t_LVM_GROUP;
            done
            ;;
        m)
            # Get the VM Host Name
            t_LVM_DEV_MAPPER_DIR="${OPTARG}"
            while [ -z "${t_LVM_DEV_MAPPER_DIR}" ]; do
                # echo "(mapper) Device Mapper Name: "
                read -p "LVM Device Mapper Name, -m [devmappername]: " t_LVM_DEV_MAPPER_DIR;
            done
            ;;
        *)
            usage_info
            ;;
    esac
done

shift $((OPTIND-1))
###########################################
# DESCRIPTION: CHECK VARIABLES
# check for any empty variables and require them
# run usage_info() and then param_init()
###########################################
if ( is_empty "${t_DISK_DEV}" ) || ( is_empty "${t_LVM_DEV_MAPPER_DIR}" ) || ( is_empty "${t_DISK_PTYPE}" ); then
	usage_info
    exit 1
fi
###########################################
# LVM Group
# DESCRIPTION:
# Get the default volume group
###########################################
if ( is_empty "${t_lvm_group}" ); then
	t_LVM_GROUP=$(sudo vgs --noheadings -o vg_name | xargs)
fi
###########################################
# INFORMATION
# DESCRIPTION: 
# Print script's purpose message to the console 
###########################################
cat <<__INFO__

Creating NEW LVM partition: ${t_DISK_DEV}

  Disk: ${t_dev}${t_DISK_DEV}
  Lable: ${t_DISK_LABEL}
  LVM Group: ${t_LVM_GROUP}
  LVM Device Mapper: ${t_LVM_DEV_MAPPER_DIR}

__INFO__
###########################################
# DESCRIPTION: CHECK ROOT
# run is_root() for safety reasons
###########################################
t_boot_device=$(findmnt -n -o SOURCE /boot | xargs)
t_root_device=$(ls /sys/block/dm-0/slaves/ | xargs)
t_root_lvm=$(findmnt -n -o SOURCE / | xargs)
cat <<__INFO__

 Checking root's values against the extra volume

    ROOT: 
	${t_root_lvm}
	${t_root_device}

    [NEW] Extra Volume: (${t_DISK_LABEL})
	${t_LVM_DEV_MAPPER_DIR}
	${t_DISK_DEV}

__INFO__

if ( is_root "${t_root_lvm}" "${t_root_device}" ); then
	usage_info
	exit 1
fi
###########################################
# PARTED
# DESCRIPTION: 
# Print Details, create partition and expand
# Print the current partition(s) state
###########################################
sudo parted "${t_dev}${t_DISK_DEV}" print
sleep 15

# ensure the device isn't mounted already
echo -e "[INFO]: Ensure device isn't mounted: ${t_DISK_DEV}"
sudo umount "${t_dev}${t_DISK_DEV}" 
sleep 5

# create a gpt or msdos partition table (depending on ptype variable defined above)
echo -e "[INFO]: Creating partition table on ${t_DISK_DEV}"
sudo parted -s -a optimal "${t_dev}${t_DISK_DEV}" mktable "${t_DISK_PTYPE}"
sleep 5

# create the partition, starting at 1MB which may be better with newer disks
echo -e "[INFO]: Creating partition and setting the LVM flag on ${t_DISK_DEV}"
sudo parted -s -a optimal -- "${t_dev}${t_DISK_DEV}" unit compact mkpart primary ext4 "1M" "100%" set 1 lvm on
sleep 5

# wipefs on new or existing partitions when they're formatted
echo -e "[INFO]: Performed Wipefs to avoid problems with old filesystem signatures"
sudo wipefs -a "${t_dev}${t_DISK_DEV}1"

# Make filesystem on the LVM partition
echo -e "[INFO]: Creating filesystem on the LVM partition: ${t_DISK_DEV}1"
sudo mkfs.ext4 -F -j -v -L "${t_DISK_LABEL}" "${t_dev}${t_DISK_DEV}1"
echo -e "[DONE]: Phase 1."

# Add Logical Volume to existing VG
echo -e "[INFO]: Extend existing VG to the new LV: ${t_DISK_DEV}1"
sudo vgextend "${t_LVM_GROUP}" "${t_dev}${t_DISK_DEV}1"

# Extend /dev/mapper/[name] to consume the new space 
echo -e "[INFO]: Extend the logical volume."
sudo lvextend -l +100%FREE "${t_LVM_DEV_MAPPER_DIR}"

# Resize the filesystem
echo -e "[INFO]: Resize the filesystem."
sudo resize2fs "${t_LVM_DEV_MAPPER_DIR}"
echo -e "[DONE]: Phase 2."
###########################################
# FINISH
# DESCRIPTION: 
# Guest OS, Print LVM Information.
# $(df -hl -T -x tmpfs -x devtmpfs | sort -r)
###########################################
cat <<__INFO__
#===========================================
Date: $(date)

Instance Extra Volume Information:

$(sudo parted "${t_dev}${t_DISK_DEV}" print)

Disk: ${t_DISK_DEV}1
  Lable: ${t_DISK_LABEL}
  LVM Group: ${t_LVM_GROUP}
  LVM Device Mapper: ${t_LVM_DEV_MAPPER_DIR}

$(sudo vgs)

__INFO__
