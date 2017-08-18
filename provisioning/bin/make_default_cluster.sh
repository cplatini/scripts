#!/bin/bash
###########################################
# DEBUGGING
###########################################
# /bin/sh (usually a symbolic link to bash)
# /usr/bin/bash
# /usr/bin/env bash
# Debugging: set -x
# set -x # Print a trace of simple commands and their arguments
###########################################
# SCRIPT INFORMATION
###########################################
# This script makes a call to the OpenStack API, using the python nova 
# client, and provisions instances based on pre-defined flags. After 
# the provisioning happens, the script then connects to the newly 
# created instance and begins the process of checking, fixing, and 
# modeling the required settings for the host to operate correctly. 
#
# sudo ./make_default.sh -v
#
# Make default: It's possible to invoke this script with command-line arguments.
#
#    Example: ./make_default.sh -a [API_NAME] -h [HOST_NAME] -z [AVAIL_ZONE] -e [ENV_NAME] -s [VM_TYPE]
#
# Environment options:
#
#   Rackspace: (raxdfw)
#     DEVINT, DI2, QA, CLIENTTEST, PROD
#
#   Sungard: (sgden1)
#     SGDI, SGQA, SGCT, SGPROD
#
# API_NAME: Location of API: raxdfw or sgden1
# HOST_NAME: Depends on the server's function.
# AVAIL_ZONE: AZ-DI2-STANDARD-1, AZ-DI2-STANDARD-2
# ENV_NAME: DEVINT, DI2, QA, CLIENTTEST, PROD
# VM_TYPE: HDD, NLPD, NLPR NLPQ, CQLRTR, or [OS_ID]
#
###########################################
# SCRIPT VERSION & EDITS
###########################################
s_build_date='[Fri May 1 15:11:43 MDT 2015]'
s_build_update='[Fri Jan 15 20:22:10 UTC 2016]' # Change me, if changes are made
s_org='3M HIS, Cloud Systems'
s_author='Nicholas M. Houle, Richard DeHaven'; # Add name ", name" when changes are made
s_version='2.5.0'
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
# SCRIPT VARIABLES
# Define variables to be used
# API_NAME='raxdfw'
# HOST_NAME: t-vm-nhoule ('t' denotes test VM)
# AVAIL_ZONE: AZ-NP-STANDARD-1, AZ-NP-STANDARD-2
# ENV_NAME: DEVINT, DI2, QA, CLIENTTEST, PROD
# VM_TYPE: HDD, NLPD, NLPR, NLPQ, CQLRTR, [OS_ID]
# DOMAIN: Set further down in script.
# SDLC_DOMAIN: Set further down in script.
###########################################
API_NAME=''
HOST_NAME=''
AVAIL_ZONE=''
ENV_NAME=''
VM_TYPE=''
#### Identify P_ROOT
#P_ROOT='/home/drainwater/provisioning'
#P_ROOT='/extra/t_nhoule/3M/projects/scripts/provisioning'
S_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
P_ROOT=$( dirname "$S_ROOT" )
###########################################
# FUNCTION: usage_info
# DESCRIPTION: echo the script usage_info
###########################################
usage_info() { 
cat <<__SCRIPTUSAGE__

Make default: It's possible to invoke this script with command-line arguments.

    Example: $0 -a [API_NAME] -h [HOST_NAME] -z [AVAIL_ZONE] -e [ENV_NAME] -s [VM_TYPE]

Environment options:

  Rackspace: (raxdfw)
    DEVINT, DI2, QA, CLIENTTEST, PROD

  Sungard: (sgden1)
    SGDI, SGQA, SGCT, SGPROD

__SCRIPTUSAGE__

  exit $?
}
###########################################
# FUNCTION: param_init
# DESCRIPTION: LOOP, TEST, GET, SET PARAMATERS
###########################################
param_init() { 

    # Get the API Name
    while [ -z "${API_NAME}" ]; do
        read -p "API Name, -a [api]: " API_NAME;
    done

    # Get the VM Host Name
    while [ -z "${HOST_NAME}" ]; do
        read -p "VM Host Name, -h [hostname]: " HOST_NAME;
    done

    # Get the VM Availability Zone
    while [ -z "${AVAIL_ZONE}" ]; do
        read -p "VM Availability Zone, -z [zone]: " AVAIL_ZONE;
    done   

    # Get the VM Environment Name
    while [ -z "${ENV_NAME}" ]; do
        read -p "VM Environment Name, -e [environment]: " ENV_NAME;
    done

    # Get the Virtual Machine Type
    while [ -z "${VM_TYPE}" ]; do
        read -p "VM Server Type, -s [server]: " VM_TYPE;
    done       
}
###########################################
# FUNCTION: is_integer
# DESCRIPTION: 
# Check value is not empty 
# Try to print the value using printf
# Parameters: 
#   $1 = value to check
###########################################
function is_integer() {
  # Check value is not empty and a number
  if [[ -n "$1" ]]; then
      printf "%d" $1 > /dev/null 2>&1
      return $?
  fi
  # return 1, not a number
  return 1
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
# FUNCTION: to_lower
# DESCRIPTION: Check value is empty 
# Parameters: 
#   $1 = value to check
#   $1 convert to lower case
###########################################
function to_lower() {
  t_param=$1
  # Check value is not empty, for speed.
  if [[ -z "${t_param}" ]]; then
    #return 0, is empty, but we don't care
    return 0
  fi
  # Convert to lower case
  echo -e "${t_param}" | tr '[:upper:]' '[:lower:]' | xargs 2>/dev/null
  #return 0, we don't care
  return 0
}
###########################################
# FUNCTION: error_cleanup()
# FUNCTION: check_exit_Status()
# DESCRIPTION:
# Check the exit status of the last command
# Parameters: 
#   $1 = exit_status
#   $2 = test_skip (flag)
# Pass "skip_OK" to function, if failure doesn't matter
###########################################
function error_cleanup() {
# We caught an error, so try to clean up the mess
cat <<__TRAPPED__
[ERROR]: We caught an error, so we can't proceed. 
[CLEANING]: Perform some cleanup before exiting.
__TRAPPED__

    # Check and delete instance
    if ( ! is_empty "${OS_UUID}" ); then
      nova --insecure delete "${OS_UUID}"
    fi

  return $?
}
# Handle exit status errors
function check_exit_status() {
    exit_status=$1
    test_skip=$2 

    if [ "${exit_status}" -ne 0 ]; then # test failed
        if [ -n "${test_skip}" ]; then
          # write test skip to files
          echo -e "[CHECK STATUS]: Skipped [ OK ]"
          return 
        else
          # ERROR: Caught a bad exit status.
          error_cleanup
          exit $?
        fi
    fi
    #echo -e "[CHECK STATUS]: Status [ OK ]"
}
###########################################
# FUNCTION: do_cleanup()
# DESCRIPTION:
# Check for custom error text passed to function
# Check for UUID and force a nova delete 
###########################################
function do_cleanup() {
  t_error_text=$1
  OS_UUID="${OS_UUID:=}"
  OS_UUID="$(echo -e "${OS_UUID}" | xargs)"

  # Check for custom error text passed to function
  if ( ! is_empty "${t_error_text}" ); then
    echo -e "[ERROR]: ${t_error_text}"
  fi

  # Check for UUID and force a nova delete
  if ( ! is_empty "${OS_UUID}" ); then
    nova --insecure delete "${OS_UUID}"
    echo "[INFO]: Deleted failed instance: \"${OS_UUID}\" "
  fi

  exit $?
}
###########################################
# FUNCTION: do_cleanup()
# DESCRIPTION:
# Check for custom error text passed to function
# Check for UUID and force a nova delete 
###########################################
function do_destroy() {
  old_instance=$(nova --insecure list --name \^${HOST_NAME}\$ | egrep -i "[[:space:]]${HOST_NAME}[[:space:]]" | awk -F'|' '{print $2}' | xargs echo -n)

  if ( ! is_empty "${old_instance}" ); then

# Instance found, try to clean up the mess
cat <<__INFO__
[GET]: Instance found: "${HOST_NAME}", "${old_instance}"
[INFO]: Attempt to delete existing instance by ID. 
__INFO__

    # Try to remove from SGAS monitor
    if [[ ${API_NAME} == "sgden1" ]]; then
      old_mgmt_ipaddr=$(nova --insecure show ${old_instance} | egrep -i "[[:space:]]network[[:space:]]" | grep "SGAS_MGMT" | awk -F'|' '{print $3}' | xargs echo -n)
      echo "[INFO]: Sending Decomission Request to Sungard OSS_API"
      curl http://10.10.221.250/api/provisioning \
      -X DELETE \
      -H "Content-Type: application/x-www-form-urlencoded" \
      -d "={\"host\":\"${HOST_NAME}\",\"ip_address\":\"${old_mgmt_ipaddr}\",}";
    fi

    # Try to delete any existing VMs which match this hostname
    nova --insecure delete $(nova --insecure list --name \^${HOST_NAME}\$ | egrep -i "[[:space:]]${HOST_NAME}[[:space:]]" | awk -F'|' '{print $2}' | xargs echo -n)
    # Check the status of the last command
    if [[ ! $? = 0 ]]; then
      do_cleanup "Old Instance Delete Failed"
      exit $?
    else
      echo "[INFO]: Instance Deleted [ OK ]"
      echo "[INFO]: Instance is being purged: 3 minutes."
      # 3 minuets of waiting time while the instance is purged. 
      sleep 3m  
    fi

  fi

  return $?
}
###########################################
# FUNCTION: trap_cleanup()
# DESCRIPTION: trap exit signals and clean-up
# Catching a signal (128 + n)
# define SIGHUP     1    /* Hangup, generated when terminal disconnects */
# define SIGINT     2    /* Terminal interrupt, generated from terminal special char */
# define SIGQUIT    3    /* (*) Terminal quit, generated from terminal special char */
# define SIGTERM    15   /* (*) Software termination signal (sent by kill by default). */
###########################################
read -d '' traplist <<__TRAPLIST__
SIGHUP
SIGINT
SIGQUIT
SIGTERM
__TRAPLIST__
# Cleanup function for after trapping
function trap_cleanup()
{
# Try to clean up the mess
# Script: $0
cat <<__TRAPPED__
[TRAP]: Script exited before completion of deployment. 
[CLEANING]: Perform some cleanup before exiting.
__TRAPPED__

    # Check and delete instance
    if ( ! is_empty "${OS_UUID}" ); then
      echo -e "[ $0 ]: Delete failed instance: \"${OS_UUID}\""
      nova --insecure delete "${OS_UUID}"
    fi

    return $?
}
# Handle trapped SIGNALS
function c_traps() {
    # Do clean-up operations
    trap_cleanup
    exit $?
}
# On interruption
trap "c_traps" ${traplist}
trap -- "echo [EXIT]" EXIT
###########################################
# DESCRIPTION: CHECK, VALIDATE, SET OPTIONS
# getopts: init (param, param, param, param)
# Must have all command-line options, except -v
###########################################
while getopts ":va:h:z:e:s:" o; do
    case "${o}" in
        v)
            # Version Info: -v is used for version information
            version_info
            ;;
        a)
            # Get the API Name
            API_NAME="${OPTARG}"
            while [ -z "${API_NAME}" ]; do
                read -p "API Name, -a [api]: " API_NAME;
            done
            ;;
        h)
            # Get the VM Host Name
            HOST_NAME="${OPTARG}"
            while [ -z "${HOST_NAME}" ]; do
                # Check all command-line options or 
                if [[ ${HOST_NAME} =~ [_] ]]; then
                    echo -e "$(clear)"
                    do_cleanup "Underscores in the host name are not allowed. [ Failed ]"
                    HOST_NAME=''
                fi
                read -p "VM Host Name, -h [hostname]: " HOST_NAME;
            done
            ;;
        z)
            # Get the VM Availability Zone
            AVAIL_ZONE="${OPTARG}"
            while [ -z "${AVAIL_ZONE}" ]; do
                read -p "VM Availability Zone, -z [zone]: " AVAIL_ZONE;
            done
            ;;
        e)
            # Get the VM Environment Name
            ENV_NAME="${OPTARG}"
            while [ -z "${ENV_NAME}" ]; do
                read -p "VM Environment Name, -e [environment]: " ENV_NAME;
            done
            ;;
        s)
            # Get the Virtual Machine Type
            VM_TYPE="${OPTARG}"
            while [ -z "${VM_TYPE}" ]; do
                read -p "VM Server Type, -s [server]: " VM_TYPE;
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
if [ -z "${API_NAME}" ] || [ -z "${HOST_NAME}" ] || [ -z "${AVAIL_ZONE}" ] || [ -z "${ENV_NAME}" ] || [ -z "${VM_TYPE}" ]; then
    usage_info
    #param_init
fi
API_NAME=$(to_lower "${API_NAME}")
HOST_NAME=$(to_lower "${HOST_NAME}")
###########################################
# SOURCE SCRIPTS by VARIABLES
###########################################
[ -f "${P_ROOT}/properties/properties.default.${ENV_NAME}" ] && source ${P_ROOT}/properties/properties.default.${ENV_NAME} || { echo "[ERROR]: Unable to source environment properties file."; exit 1 ;}
[ -f "${P_ROOT}/bin/config-default.${ENV_NAME}" ] && source ${P_ROOT}/bin/config-default.${ENV_NAME} || { echo "[ERROR]: Unable to source environment config file."; exit 1 ;}
###########################################
# DESCRIPTION: DOMAIN
# This variable is found in the set_[env]
# We source to get this variable, and set it.
# DOMAIN='raxdfw.3mhis.net' -or-
# DOMAIN='sgden1.3mhis.net'
###########################################
DOMAIN="${DOMAIN:=}"
if ( is_empty "${DOMAIN}" ); then
    # We get this variable after we source
    do_cleanup "No domain specified, exiting. [ Failed ]"
    exit $?
fi
DOMAIN=$(to_lower "${DOMAIN}")
###########################################
# DESCRIPTION: SWITCH CASE FOR VARIABLES
# Check the VM_TYPE, and set the OS_FLAVOR
###########################################
if [ "${API_NAME}" == "raxdfw" ]; then
###########################################
# Rackspace case VM_TYPE
# DESCRIPTION: SWITCH CASE FOR VARIABLES
# Check the VM_TYPE, and set the OS_FLAVOR
###########################################
  case "${VM_TYPE}" in
      ELSEARCHKWB)
        # esb.medium - 4 vCPUs, 64G memory, 100G disk, 160 ephemeral
        OS_FLAVOR='53'
        # CentOS 6.5| 84af9909-60f9-49eb-882c-b13df4ad602c | CentOS-6.5_x86_64.lvm.v1.00
        OS_IMAGE='84af9909-60f9-49eb-882c-b13df4ad602c'
        ;;
      ELSEARCHLOG)
        # esb.medium - 4 vCPUs, 64G memory, 100G disk, 160 ephemeral
        OS_FLAVOR='53'
        # Overide the OS Image variable found in the properties file
        OS_IMAGE='84af9909-60f9-49eb-882c-b13df4ad602c'
        ;;
      *)
        echo "[INFO]: \$VM_TYPE, unknown flavor specified: ${VM_TYPE}"
        echo "[INFO]: Checking for flavor by ID: ${VM_TYPE}"
        nova --insecure flavor-list | awk -F'|' '{print $2}' | grep -qi "^\s${VM_TYPE}"
        #nova flavor-list | grep -q "${VM_TYPE}"
          if [ $? -eq 0 ]; then
            echo "[GET]: Flavor found, setting OS_FLAVOR=${VM_TYPE}"
            OS_FLAVOR="${VM_TYPE}"
          else
            do_cleanup "No OS_FLAVOR found, exiting. [ Failed ]"
            exit $?
          fi;
        ;;
  esac

elif [ "${API_NAME}" == "sgden1" ]; then
###########################################
# Sungard case VM_TYPE
# DESCRIPTION: SWITCH CASE FOR VARIABLES
# Check the VM_TYPE, and set the OS_FLAVOR
###########################################
  case "${VM_TYPE}" in
      ELSEARCHKWB)
        # c4.large.e250  - 4 vCPUs, 16G memory, 150G disk, 250 ephemeral
        OS_FLAVOR='77f599bb-d09a-4d51-9705-e0dde94a9df6'
        # Overide the OS Image variable found in the properties file
        # RHEL 6.6 | SGAS RHEL 6.6 GA v2 | 258e3dae-da6d-4e3f-9903-a06e20d28862
        OS_IMAGE='258e3dae-da6d-4e3f-9903-a06e20d28862'
        ;;
      ELSEARCHLOG)
        # c4.large.e250  - 4 vCPUs, 16G memory, 150G disk, 250 ephemeral
        OS_FLAVOR='77f599bb-d09a-4d51-9705-e0dde94a9df6'
        # Overide the OS Image variable found in the properties file
        # RHEL 6.6 | SGAS RHEL 6.6 GA v2 | 258e3dae-da6d-4e3f-9903-a06e20d28862
        OS_IMAGE='258e3dae-da6d-4e3f-9903-a06e20d28862'
        ;;
      *)
        echo "[INFO]: \$VM_TYPE, unknown flavor specified: ${VM_TYPE}"
        echo "[INFO]: Checking for flavor by ID: ${VM_TYPE}"
        nova --insecure flavor-list | awk -F'|' '{print $2}' | grep -qi "^\s${VM_TYPE}"
        #nova flavor-list | grep -q "${VM_TYPE}"
          if [ $? -eq 0 ]; then
            echo "[GET]: Flavor found, setting OS_FLAVOR=${VM_TYPE}"
            OS_FLAVOR="${VM_TYPE}"
          else
            do_cleanup "No OS_FLAVOR found, exiting. [ Failed ]"
            exit $?
          fi;
        ;;
  esac

else 
  # do_cleanup() ERROR_TEXT
  do_cleanup "Issue creating VM, case VM_TYPE with API: ${API_NAME}. [ Failed ]"
  exit 1
fi
###########################################
# DESCRIPTION: SWITCH CASE FOR VARIABLES
# Check the ENV_NAME, and set the PUPPET_ENV
###########################################
SDLC_DOMAIN="${SDLC_DOMAIN:=}"
case "${ENV_NAME}" in
    PROD)
      # Puppet SOA_PRODUCTION
      PUPPT_ENV="SOA_PRODUCTION"
      SDLC_DOMAIN="soa-pr.${DOMAIN}"
      ;;
    CLIENTTEST)
      # Puppet SOA_CT
      PUPPT_ENV="SOA_CT"
      SDLC_DOMAIN="soa-ct.${DOMAIN}"
      ;;
    QA)
      # Puppet SOA_QA
      PUPPT_ENV="SOA_QA"
      SDLC_DOMAIN="soa-qa.${DOMAIN}"
      ;;
    DI2)
      # Puppet SOA_DI2
      PUPPT_ENV="SOA_DI2"
      SDLC_DOMAIN="soa-di2.${DOMAIN}"
      ;;
    DEVINT)
      # Puppet SOA_DevINT
      PUPPT_ENV="SOA_DevINT"
      #SDLC_DOMAIN="soa-devint.${DOMAIN}"
      ;;
    SGDI)
      # Puppet SOA_DI
      PUPPT_ENV="SOA_DI"
      SDLC_DOMAIN="soa-di.${DOMAIN}"
      ;;
    SGQA)
      # Puppet SOA_DI2
      PUPPT_ENV="SOA_QA"
      SDLC_DOMAIN="soa-qa.${DOMAIN}"
      ;;
    SGCT)
      # Puppet SOA_DI2
      PUPPT_ENV="SOA_CT"
      SDLC_DOMAIN="soa-ct.${DOMAIN}"
      ;;
    SGPROD)
      # Puppet SOA_DI2
      PUPPT_ENV="SOA_PRODUCTION"
      SDLC_DOMAIN="soa-pr.${DOMAIN}"
      ;;
    *)
      # We shouldn't see this final case
      do_cleanup "\$ENV_NAME was not set or isn't understood, ${ENV_NAME}. [ Failed ]"
      usage_info
      ;;
esac
SDLC_DOMAIN=$(to_lower "${SDLC_DOMAIN}")
###########################################
# FDNQ: SET THE FULLY QUALIFIED DOMAIN NAME 
# Set FQDN, OLD: FQDN="${HOST_NAME}.${DOMAIN}"
# If found empty we are exiting.
###########################################
FQDN="${HOST_NAME}.${SDLC_DOMAIN}"
if ( is_empty "${FQDN}" ); then
    # This is probably unnecessary, but it's too important to ignore.
    # SAFETY FIRST: empty, exit
    do_cleanup "FQDN is empty [ Failed ]"
    exit $?
fi
FQDN=$(to_lower "${FQDN}")
###########################################
# CLEAN UP OLD/EXISTING VMs  
# Check if VM matches this hostname
# If match found, delete the existing VM
# Deployments:
# Only for Deployments where existing VMs need to be deleted
###########################################
if [[ "${VM_TYPE}" == "ELSEARCHKWB" ]] || [[ "${VM_TYPE}" == "ELSEARCHLOG" ]]; then
  # This will look for existing VMs that match the host name
  # This will delete the existing VM and then provision a new server
  do_destroy
fi
###########################################
# BUILD PROVISIONING 
# BUILDING VM, BOOT, LOG, CLEAN UP ON ERROR
# Raxdfw Net
###########################################
# Rackspace SSH IP and port creation
if [ "${API_NAME}" == "raxdfw" ]; then
###########################################
# BUILD PROVISIONING 
# BUILDING VM, BOOT, LOG, CLEAN UP ON ERROR
# Raxdfw Net
###########################################
BOOT_STRING="boot_instance=nova --insecure boot \
--flavor \"${OS_FLAVOR}\" \
--image \"${OS_IMAGE}\" \
--nic \"net-id=${OS_NETWORK}\" \
--security-groups \"${OS_SECURITY_GROUPS}\" \
--availability-zone \"${AVAIL_ZONE}\" \
--key_name \"${OS_KEYNAME}\" \
--user-data \"${P_ROOT}/scripts/default.sh\" \"${HOST_NAME}\"";

boot_instance=$(nova --insecure boot \
--flavor "${OS_FLAVOR}" \
--image "${OS_IMAGE}" \
--nic "net-id=${OS_NETWORK}" \
--security-groups "${OS_SECURITY_GROUPS}" \
--availability-zone "${AVAIL_ZONE}" \
--key_name "${OS_KEYNAME}" \
--user-data "${P_ROOT}/scripts/default.sh" "${HOST_NAME}");

elif [ "${API_NAME}" == "sgden1" ]; then
###########################################
# BUILD PROVISIONING 
# BUILDING VM, BOOT, LOG, CLEAN UP ON ERROR
# SGBackup Net
#  --nic \"net-id=30a962db-16d6-4f6d-b4a1-b676d6fe6aa3\" \
#  --nic "net-id=30a962db-16d6-4f6d-b4a1-b676d6fe6aa3" \
###########################################
BOOT_STRING="boot_instance=nova --insecure boot \
--flavor \"${OS_FLAVOR}\" \
--image \"${OS_IMAGE}\" \
--nic \"net-id=${OS_NETWORK}\" \
--nic \"net-id=77ee3b2e-7de9-47b4-90d7-388f3f0007f0\" \
--nic \"net-id=30a962db-16d6-4f6d-b4a1-b676d6fe6aa3\" \
--security-groups \"${OS_SECURITY_GROUPS}\" \
--availability-zone \"${AVAIL_ZONE}\" \
--key_name \"${OS_KEYNAME}\" \
--user-data \"${P_ROOT}/scripts/default.sh\" \"${HOST_NAME}\"";

boot_instance=$(nova --insecure boot \
--flavor "${OS_FLAVOR}" \
--image "${OS_IMAGE}" \
--nic "net-id=${OS_NETWORK}" \
--nic "net-id=77ee3b2e-7de9-47b4-90d7-388f3f0007f0" \
--nic "net-id=30a962db-16d6-4f6d-b4a1-b676d6fe6aa3" \
--security-groups "${OS_SECURITY_GROUPS}" \
--availability-zone "${AVAIL_ZONE}" \
--key_name "${OS_KEYNAME}" \
--user-data "${P_ROOT}/scripts/default.sh" "${HOST_NAME}");

else 
  # do_cleanup() ERROR_TEXT
  do_cleanup "Issue creating VM with API: ${API_NAME}. [ Failed ]"
  exit 1
fi
###########################################
# BEGIN PROVISIONING 
###########################################
cat <<__BEGINSCRIPT__
#===========================================
Date: $(date)
API: ${API_NAME} 

  BEGIN PROVISION: ${HOST_NAME}
  BUILDING VM: ${FQDN}

  BOOT_STRING: ${BOOT_STRING}
#===========================================
__BEGINSCRIPT__
###########################################
# Get/Store OS_UUID and BOOT the VM
###########################################
OS_UUID=$(echo "${boot_instance}" | egrep -i "[[:space:]]id[[:space:]]" | awk -F'|' '{print $3}' | xargs echo -n)
if ( ! is_empty "${boot_instance}" ); then
# Check for case where we might have a nova boot error

  # ERROR (CommandError):  
  echo "${boot_instance}" | egrep -i "[[:space:]]ERROR[[:space:]](CommandError)[[:space:]]"
  if [ $? -eq 0 ]; then
    # do_cleanup() ERROR_TEXT
    echo -e "${boot_instance}"
    do_cleanup "(CommandError): boot_instance command error [ Failed ]"
    exit 1 
  fi

  # ERROR (OverLimit): Quota exceeded for cores: Requested 4, 
  # but already used 148 of 150 cores (HTTP 413) (Request-ID: req-a6d80dd3-3bf1-4248-8294-025110d28bac)
  echo "${boot_instance}" | egrep -i "[[:space:]]ERROR[[:space:]](OverLimit)[[:space:]]"
  if [ $? -eq 0 ]; then
    # do_cleanup() ERROR_TEXT
    echo -e "${boot_instance}"
    do_cleanup "(OverLimit): Quota exceeded [ Failed ]" 
    exit 1 
  fi
  
  # ERROR: Unknown or not defined error
  echo "${boot_instance}" | egrep -i "[[:space:]]ERROR[[:space:]]"
  if [ $? -eq 0 ]; then
    # do_cleanup() ERROR_TEXT
    echo -e "${boot_instance}"
    do_cleanup "boot_instance has error [ Failed ]"
    exit 1 
  fi

# Clean, Print boot output to console
echo -e "${boot_instance}"

else 
  # do_cleanup() ERROR_TEXT
  do_cleanup "boot_instance is empty. [ Failed ]"
  exit 1
fi
echo "[INFO]: Booting Instance: 1 minute."
sleep 1m
###########################################
# CHECK INSTANCE IP ADDRESS
# Check for proper IP address (May still be building)
# Attempt to find the IP address 3 times before failing
###########################################
echo -e "[INFO]: Checking for a valid IPv4 address."
ip_check='1'
ip_check_count='1'
# Ensure we get a value that isn't empty
while [ "${ip_check}" != 0 ]; do

  # Depending on API: Get the instance IP address
  if [ "${API_NAME}" == "raxdfw" ]; then
    # Get the instance's IP by OS_UUID and store it
    instance_ipaddr=$(nova --insecure show ${OS_UUID} | egrep -i "[[:space:]]network[[:space:]]" | awk -F'|' '{print $3}' | xargs echo -n)
  fi

  # Depending on API: Get the instance IP address
  if [ "${API_NAME}" == "sgden1" ]; then
    # Get the instance's IP by OS_UUID and store it
    instance_ipaddr=$(nova --insecure show ${OS_UUID} | egrep -i "[[:space:]]network[[:space:]]" | grep -v "SGAS" | awk -F'|' '{print $3}' | xargs echo -n)
    sgas_mgmt_ipaddr=$(nova --insecure show ${OS_UUID} | egrep -i "[[:space:]]network[[:space:]]" | grep "SGAS_MGMT" | awk -F'|' '{print $3}' | xargs echo -n)
  fi

  # Check for an empty string
  if ( ! is_empty "${instance_ipaddr}" ); then
    # set, not empty
    ip_check='0'
    break
  else 
    # set, is empty
    ip_check='1'
  fi

  let "ip_check_count+=1"
  if [ "${ip_check_count}" -lt 90 ]; then
    # 30 x 90 = 45 minuets of waiting time
    echo "[INFO]: IP attempt ${ip_check_count}: Sleep 30 seconds."
    sleep 30
  else
    # do_cleanup() ERROR_TEXT
    do_cleanup "Couldn't get the Host's IP after ${ip_check_count} checks [ Failed ]"
    exit 1
  fi
done
# Ensure we get a valid IP address or delete the instance
third_octet=$(echo ${instance_ipaddr} | awk -F'.' '{print $3}' | xargs echo -n)
fourth_octet=$(echo ${instance_ipaddr} | awk -F'.' '{print $4}' | xargs echo -n)
# Check if variables are integers
if ( ! is_integer ${third_octet} ) || ( ! is_integer ${fourth_octet} ); then
  # do_cleanup() ERROR_TEXT
  do_cleanup "Illegal IP address: not a number. [ Failed ]"
  exit 1
fi
# Ensure the fourth octet isn't 0 or 255
# This depends, and would be valid in a /16 subnet, 255,255.0.0
# The network address (.0) and the network broadcast address (.255)
t_network_id='0'
t_braodcast_id='255'
if [ "${fourth_octet}" -eq "${t_network_id}" ] || [ "${fourth_octet}" -eq "${t_braodcast_id}" ]; then
  # do_cleanup() ERROR_TEXT
  do_cleanup "Illegal IP address: fourth octet contains (0) or (255). [ Failed ]"
  exit 1
fi
echo "[INFO]: IPv4 address good, attempt ${ip_check_count}. [ OK ]"
###########################################
# SSH_PORT: Set the SSH port number
# DESCRIPTION: Create the SSH port from the 
# IPv4 3rd & 4th octets
# Rackspace SSH IP and port creation
# Sungard SSH IP and port creation
###########################################
if [ "${API_NAME}" == "raxdfw" ]; then
###########################################
# INFORMATION: API raxdfw
# Rackspace SSH IP and port creation
# Guest OS, Print VM's Information.
###########################################
echo "[INFO]: Building IP and port for Rackspace"
ssh_port=$(printf "%d%.3d" "+1${third_octet}" "${fourth_octet}")
ssh_host="${PAT_IPADDR}"

cat <<__INFO__
#===========================================
API: ${API_NAME}
Created ${FQDN}
UUID: "${OS_UUID}"

IP ADDRESS: ${instance_ipaddr}
Octet 3: ${third_octet}
Octet 4: ${fourth_octet}

SSH PORT: ${ssh_port}
#===========================================
__INFO__

elif [ "${API_NAME}" == "sgden1" ]; then
###########################################
# INFORMATION: API sgden1
# Sungard SSH IP and port creation
# Guest OS, Print VM's Information.
###########################################
echo "[INFO]: Building IP and port for Sungard"
ssh_port='22'
ssh_host="${instance_ipaddr}"

cat <<__INFO__
#===========================================
API: ${API_NAME}
Created ${FQDN}
UUID: "${OS_UUID}"

IP ADDRESS: ${instance_ipaddr}
SSH PORT: ${ssh_port}
#===========================================
__INFO__

# Issue with SSH IP and port creation
else 
  do_cleanup "Issue creating SSH IP and port. [ Failed ]" 
fi
###########################################
# SSH/SCP Configuration
# DESCRIPTION: 
# Set the SSH/SCP strings
# Check for proper SSH connection (May still be building)
# SSH_STRING:-q -i /home/drainwater/provisioning/certs/private_key.pem cloud-user@72.3.199.161 -p 10020
# ROOT_STRING:-q -i /home/drainwater/provisioning/certs/private_key.pem root@72.3.199.161 -p 10020
# SCP_STRING:-i /home/drainwater/provisioning/certs/private_key.pem -P 10020
###########################################
echo -e "[INFO]: Ensure correct permissions on certs directory."
find ${P_ROOT}/certs/ -type f -exec chmod 0600 {} \;
check_exit_status $?
# Set SSH variables
ssh_puppet_console="-q -i ${P_ROOT}/certs/puppet_key.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null puppetworker@puppet-master-01.sys.raxdfw.3mhis.net";
ssh_string="-q -i ${P_ROOT}/certs/${ENV_PK_NAME} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null cloud-user@${ssh_host} -p ${ssh_port}";
root_string="-q -i ${P_ROOT}/certs/${ENV_PK_NAME} -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@${ssh_host} -p ${ssh_port}";
echo "SSH_STRING: ${ssh_string}";
echo "ROOT_STRING: ${root_string}";
# Check for proper SSH connection (May still be building)
# This will attempt to make an SSH connection 90 times before failing
echo "[INFO]: Checking the SSH connection."
ssh_check=1
ssh_check_count=0
while [ "${ssh_check}" != 0 ]; do
ssh ${ssh_string} "sudo cat /etc/redhat-release | grep -q 'CentOS\|Red Hat'"
ssh_check=$?
let "ssh_check_count+=1"
  if [ "${ssh_check_count}" -lt 90 ]; then
      # 20 x 90 = 30 minuets of waiting time
      echo "[INFO]: SSH attempt ${ssh_check_count}: Sleep 20 seconds..."
      sleep 20
    else
      #nova --insecure delete "${OS_UUID}"
      do_cleanup "Could not SSH to Host after ${ssh_check_count} tries [ Failed ]"
      exit 1
  fi
done
echo "[INFO]: SSH connection good, attempt ${ssh_check_count}. [ OK ]"
###########################################
# functions export
# DESCRIPTION: 
# Export functions to other bash sub-shells
###########################################
typeset -fx check_exit_status error_cleanup
###########################################
# HOST Configuration
# DESCRIPTION: 
# DC Location configuration for host
# Rackspace='ssh_raxdfw.sub' -or-
# Sungard='ssh_sgden1.sub'
###########################################
if [ -f "${P_ROOT}/bin/ssh_${API_NAME}.sub" ]; then
    # Using API_NAME, configure host for the DC location.
    echo "[INFO]: Running ssh_${API_NAME}.sub routine"
    source "ssh_${API_NAME}.sub"
    check_exit_status $?
fi
###########################################
# ELSEARCHKWB HOST Configuration
# DESCRIPTION: 
# This is a requirement for ELSEARCHKWB Deployments.
# Create LVM Device Mappers for the host
# Rackspace='none' -or-
# Sungard='ssh_${API_NAME}_make_ephemeral.part'
###########################################
if [ "${API_NAME}" == "raxdfw" ]; then
###########################################
# INFORMATION: API raxdfw
# Sungard SSH IP and port creation
# Guest OS, Print VM's Information.
###########################################
  # This is for Elasticsearch Deployments.
  if [[ "${VM_TYPE}" == "ELSEARCHKWB" ]] || [[ "${VM_TYPE}" == "ELSEARCHLOG" ]]; then
    # Run ephemeral partition sub routine
    if [ -f "${P_ROOT}/bin/ssh_${API_NAME}_make_ephemeral.part" ]; then
    echo -e "[INFO]: Running Ephemeral partition sub-routine"
    ssh ${ssh_string} 'bash /dev/stdin -d vdb -p gpt -g vg2 -l lv_data01 -m /dev/mapper/vg2-lv_data01' < "ssh_${API_NAME}_make_ephemeral.part"
    fi
  fi

elif [ "${API_NAME}" == "sgden1" ]; then
###########################################
# INFORMATION: API sgden1
# Sungard SSH IP and port creation
# Guest OS, Print VM's Information.
###########################################
  # This is for Elasticsearch Deployments.
  if [[ "${VM_TYPE}" == "ELSEARCHKWB" ]] || [[ "${VM_TYPE}" == "ELSEARCHLOG" ]]; then
    # Run ephemeral partition sub routine
    if [ -f "${P_ROOT}/bin/ssh_${API_NAME}_make_ephemeral.part" ]; then
    echo -e "[INFO]: Running Ephemeral partition sub-routine"
    ssh ${ssh_string} 'bash /dev/stdin -d sdb -p gpt -g vg2 -l lv_data01 -m /dev/mapper/vg2-lv_data01' < "ssh_${API_NAME}_make_ephemeral.part"
    fi
  fi

fi
###########################################
# FINISH
# DESCRIPTION: 
# Guest OS, Print VM's Information.
###########################################
cat <<__ENDSCRIPT__
#===========================================
Date: $(date)

Instance Created: ${HOST_NAME}

  Name: ${FQDN}
  IP Address: ${instance_ipaddr}
  SSH Port: ${ssh_port}
  SSH Access: ssh ${ssh_host} -p ${ssh_port}

#===========================================
__ENDSCRIPT__
