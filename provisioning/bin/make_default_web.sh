#!/bin/bash

# Get input variables
HOST_NAME=$1
AVAIL_ZONE=$2
ENV_NAME=$3
VM_TYPE=$4

#OS_FIXED_IP=$2
P_ROOT=/home/drainwater/provisioning

source $P_ROOT/inc/*
 
# Validate inputs
if [ -z $HOST_NAME ]; then
  echo "\$HOST_NAME is not set!";
  exit 1;
fi;

if [[ $HOST_NAME =~ [_] ]]; then
    echo "underscores are not allowed as part of host name"
    exit 1;
fi;

if [ -z $VM_TYPE ]; then
    echo "\$VM_TYPE is not set!";
    exit 1;
elif [ "$VM_TYPE" == "HDD" ]; then
    # hdd_standard - 4 vCPUs, 16G memory, 60G disk, 15G ephemeral
    OS_FLAVOR='8d5a144d-9ee7-4b41-b54a-59d2f3ebe595'
elif [ "$VM_TYPE" == "NLPQ" ]; then
    # nlpq_standard - 4 vCPUs, 32G memory, 60G disk, 15G ephemeral
    OS_FLAVOR='26f395c7-bfc7-4a56-9c93-ddce14f60e1f'
else 
    echo "No flavor speficied for VM:$VM_TYPE"
    exit 1;
fi;

if [ "$ENV_NAME" != "PROD" ] && [ "$ENV_NAME" != "CLIENTTEST" ] && [ "$ENV_NAME" != "DEVINT" ] && [ "$ENV_NAME" != "QA" ] && [ "$ENV_NAME" != "DI2" ]; then
  echo "\$ENV_NAME is not set!";
  echo "Environment options are PROD, CLIENTTEST, QA, DI2 or DEVINT";
  exit 1;
fi;

source $P_ROOT/properties/properties.default.$ENV_NAME
source config-default.$ENV_NAME
source $P_ROOT/properties/net-properties.web.$ENV_NAME

# Set FQDN
FQDN=$HOST_NAME.$DOMAIN

#===========================================

echo "BEGIN PROVISION:	$FQDN";

BOOT_STRING="boot_instance=\`nova --insecure boot \
    --flavor \"$OS_FLAVOR\" \
    --image \"$OS_IMAGE\" \
    --nic \"net-id=$OS_NETWORK\" \
    --security-groups \"$OS_SECURITY_GROUPS\" \
    --availability-zone \"$AVAIL_ZONE\" \
    --key_name \"$OS_KEYNAME\" \
    --user-data \"$P_ROOT/scripts/default.sh\" \
    \"$HOST_NAME\"\`"

echo "BOOT_STRING:$BOOT_STRING"



  boot_instance=`nova --insecure boot \
    --flavor "$OS_FLAVOR" \
    --image "$OS_IMAGE" \
    --nic "net-id=$OS_NETWORK" \
    --security-groups "$OS_SECURITY_GROUPS" \
    --availability-zone "$AVAIL_ZONE" \
    --key_name "$OS_KEYNAME" \
    --user-data "$P_ROOT/scripts/default.sh" \
    "$HOST_NAME"`

OS_UUID=`echo $boot_instance | sed 's/^.* id / id /'|cut -d\| -f2|sed 's/ //g'|sort`

echo "$boot_instance"

echo "Sleeping 60 seconds..";
sleep 60;

echo -e "Created $FQDN \n  uuid \"$OS_UUID\"";

instance_details=`nova --insecure show $OS_UUID`
instance_ipaddr=`echo $instance_details | sed 's/^.* network / network / '|cut -d\| -f2|sed 's/ //g'|sort`

third_octet=`echo $instance_ipaddr |cut -d. -f3`
fourth_octet=`echo $instance_ipaddr |cut -d. -f4`

echo "3: $third_octet"
echo "4: $fourth_octet"

ssh_port=`echo \`printf %05.0f $fourth_octet\` "+1"$third_octet"000"|bc`

echo "  IP ADDRESS: $instance_ipaddr";
echo "  SSH PORT: $ssh_port";

if ((test -z "$third_octet") || (test -z "$fourth_octet")); then
    echo "Invalid IP address assigned.  Exiting..";
    exit 1;
fi;


ssh_string="-i $P_ROOT/certs/$ENV_PK_NAME -o StrictHostKeyChecking=no cloud-user@$PAT_IPADDR -p $ssh_port"

root_string="-i $P_ROOT/certs/$ENV_PK_NAME  root@$PAT_IPADDR -p $ssh_port"
scp_string="-i $P_ROOT/certs/$ENV_PK_NAME  -P $ssh_port"

####################################################################################################
# SSH_STRING:-i /home/drainwater/provisioning/certs/private_key.pem cloud-user@72.3.199.161 -p 10020
# ROOT_STRING:-i /home/drainwater/provisioning/certs/private_key.pem root@72.3.199.161 -p 10020
# SCP_STRING:-i /home/drainwater/provisioning/certs/private_key.pem -P 10020
####################################################################################################
echo "SSH_STRING:$ssh_string";
echo "ROOT_STRING:$root_string";
echo "SCP_STRING:$scp_string";

#Check for proper SSH connection (May still be building)
echo "check for good SSH connection"
ssh_check=1
ssh_check_count=0
  while [ "$ssh_check" != 0 ]; do
    ssh $ssh_string "sudo cat /etc/redhat-release | grep -q CentOS"
    ssh_check=$?
    let ssh_check_count=ssh_check_count+1
    if [ "$ssh_check_count" -lt 10 ]
       then
       sleep 30
       else
       echo "***ERROR: Could not SSH to Host after $ssh_check_count checks***"
       exit 5
    fi
  done
echo "ssh connection good after $ssh_check_count attempts"

echo "set fqdn in /etc/hosts"
ssh $ssh_string "sudo echo '$instance_ipaddr $FQDN $HOST_NAME' | sudo tee -a /etc/hosts"
echo "add netservices-01.dfw.3mhis.vm in /etc/hosts"
ssh $ssh_string "sudo echo 172.16.180.254 netservices-01.dfw.3mhis.vm | sudo tee -a /etc/hosts";
echo "add nameserver in /etc/resolv.conf"
ssh $ssh_string "sudo echo 'nameserver 172.16.180.254'|sudo tee -a /etc/resolv.conf"

echo "restart network"
ssh $ssh_string "sudo /etc/init.d/network restart"

# fix /mnt mount point
echo "fix /mnt mount point"
ssh $ssh_string "sudo perl -pi -e 's%^/dev/vda2\s+/mnt%/dev/vdb            /mnt%;' /etc/fstab"

# turn off shut down ip tables
echo "remove iptables rules"
ssh $ssh_string "sudo /sbin/service iptables stop"
ssh $ssh_string "sudo /sbin/chkconfig iptables off"

# Create the node within Puppet Dashboard
ssh -i $P_ROOT/certs/puppet_key.pem puppetworker@puppet-console.3mhis.vm \
"/opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile \
node:add name='$FQDN' groups='default,mcollective,$PUPPET_GROUPS'"


ssh -i $P_ROOT/certs/puppet_key.pem puppetworker@puppet-console.3mhis.vm "sudo puppet node clean $FQDN"

ssh $ssh_string "/usr/bin/wget -q http://mirror-fpt-telecom.fpt.net/fedora/epel/6/i386/epel-release-6-8.noarch.rpm"
ssh $ssh_string "sudo /usr/bin/yum -y install /home/cloud-user/epel-release-6-8.noarch.rpm"


#install alertlogic threatmanager agent
ssh $ssh_string "/usr/bin/wget -q ftp://netservices-01.dfw.3mhis.vm/pub/soa/rpms/al-threat-host_LATEST.x86_64.rpm"
ssh $ssh_string "sudo rpm -i /home/cloud-user/al-threat-host_LATEST.x86_64.rpm"
ssh $ssh_string "sudo /etc/init.d/al-threat-host provision --key 00c69ea46bf6f030ebb6411f17231c822ad4fa2cea6905a831 --inst-type host"
ssh $ssh_string "sudo /etc/init.d/al-threat-host start"


#install alertlogic logmanager agent
ssh $ssh_string "/usr/bin/wget -q ftp://netservices-01.dfw.3mhis.vm/pub/soa/rpms/al-log-agent-LATEST-1.x86_64.rpm"
ssh $ssh_string "sudo rpm -i /home/cloud-user/al-log-agent-LATEST-1.x86_64.rpm"
ssh $ssh_string "sudo /etc/init.d/al-log-agent provision --key 00c69ea46bf6f030ebb6411f17231c822ad4fa2cea6905a831 --inst-type host"
ssh $ssh_string "sudo /etc/init.d/al-log-agent start"
ssh $ssh_string "sudo echo '*.* @@72.32.163.12:443;RSYSLOG_FileFormat' |sudo tee -a /etc/rsyslog.conf"
ssh $ssh_string "sudo /sbin/service rsyslog restart"

RSYSLOG_CMD="sudo echo '*.* @@72.32.163.12:443;RSYSLOG_FileFormat' >> /etc/rsyslog.conf"
echo "$SYSLOG_CMD:$RSYSLOG_CMD"

# Install Puppet
scp $scp_string $P_ROOT/scripts/puppet.sh cloud-user@$PAT_IPADDR:
ssh $ssh_string "chmod +x puppet.sh;";
ssh $ssh_string "sudo ./puppet.sh";

#===========================================

sleep 5;

ssh -i $P_ROOT/certs/puppet_key.pem puppetworker@puppet-console.3mhis.vm "sudo puppet cert sign $FQDN"

sleep 5;

ssh $ssh_string "sudo /opt/puppet/bin/puppet agent -t --environment SOA_SANDBOX"

echo -e "


#===========================================

 Instance Created

 Name: $FQDN
 IP Address: $instance_ipaddr
 SSH Port: $ssh_port

#===========================================

";
