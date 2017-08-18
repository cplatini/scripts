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
    exit 1
}
###########################################
# FUNCTION: usage_info
# DESCRIPTION: echo the script usage_info
###########################################
usage_info() { 
cat <<__SCRIPTUSAGE__

Make default: It's possible to invoke this script with command-line arguments.

    Example: $0 -h [HOST_NAME] -z [AVAIL_ZONE] -e [ENV_NAME] -s [VM_TYPE]

Environment options: DEVINT, DI2, QA, CLIENTTEST, PROD

__SCRIPTUSAGE__
  # we could exit here but we're not going to
  # exit 1
}
###########################################
# DESCRIPTION: CHECK, VALIDATE, SET OPTIONS
# getopts: init (param, param, param, param)
# Must have all command-line options, except -v
###########################################
while getopts ":vh:z:e:s:" o; do
    case "${o}" in
        v)
            # -v is used for version information
            version_info
            ;;
        h)
            # Get the VM Host Name
            HOST_NAME="${OPTARG}"
            while [ -z "${HOST_NAME}" ]; do
                # Check all command-line options or 
                if [[ ${HOST_NAME} =~ [_] ]]; then
                    echo -e "$(clear)"
                    echo -e "\nHELP: Underscores in the host name are not allowed. [ Failed ]\n"
                    HOST_NAME=""
                fi;
                # echo "(Datacenter) VPC Router IP: "
                read -p "(-h hostname) VM Host Name: " HOST_NAME;
            done
            ;;
        z)
            # Get the VM Availability Zone
            AVAIL_ZONE="${OPTARG}"
            while [ -z "${AVAIL_ZONE}" ]; do
                # echo "(Server) VM Instance IP: "
                read -p "(-z zone) VM Availability Zone: " AVAIL_ZONE;
            done
            ;;
        e)
            # Get the VM Environment Name
            ENV_NAME="${OPTARG}"
            while [ -z "${ENV_NAME}" ]; do
                # echo "(Server) VM Instance Port: "
                read -p "(-e environment) VM Environment Name: " ENV_NAME;
            done
            ;;
        s)
            # Get the Virtual Machine Type
            VM_TYPE="${OPTARG}"
            while [ -z "${VM_TYPE}" ]; do
                # echo "(Server) VM Instance Port: "
                read -p "(-s server) VM Server Type: " VM_TYPE;
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
if [ -z "${HOST_NAME}" ] || [ -z "${AVAIL_ZONE}" ] || [ -z "${ENV_NAME}" ] || [ -z "${VM_TYPE}" ]; then
    usage_info
    param_init
fi
###########################################
# FUNCTION: param_init
# DESCRIPTION: LOOP, TEST, GET, SET PARAMATERS
###########################################
param_init() { 

    # Get the VM Host Name
    while [ -z "${HOST_NAME}" ]; do
        read -p "(-h hostname) VM Host Name: " HOST_NAME;
    done

    # Get the VM Availability Zone
    while [ -z "${AVAIL_ZONE}" ]; do
        read -p "(-z zone) VM Availability Zone: " AVAIL_ZONE;
    done   

    # Get the VM Environment Name
    while [ -z "${ENV_NAME}" ]; do
        read -p "(-e environment) VM Environment Name: " ENV_NAME;
    done

    # Get the Virtual Machine Type
    while [ -z "${VM_TYPE}" ]; do
        read -p "(-s server) Virtual Machine Type: " VM_TYPE;
    done       
}