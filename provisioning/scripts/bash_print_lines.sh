###########################################
# Printing multiple lines in bash
###########################################
read -d '' traplist <<__TRAPLIST__
SIGHUP
SIGINT
SIGQUIT
SIGTERM
__TRAPLIST__
echo -e "${traplist}" 

cat <<__ENDSCRIPT__
#===========================================
$(date)

Instance Created: ${HOST_NAME}

  Name: ${FQDN}
  IP Address: ${instance_ipaddr}
  SSH Port: ${ssh_port}
  SSH Access: ssh ${PAT_IPADDR} -p ${ssh_port}

#===========================================
__ENDSCRIPT__