#!/bin/bash

# 2014-03-10 - Dan Rainwater
# Create a default node in OpenStack

# Get input variables
HOST_NAME=$1
AVAIL_ZONE=$2
ENV_NAME=$3

# PROVIDE PROVISION ROOT
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

# AVAIL_ZONE= ('DFW-DSE-AZ1','DFW-DSE-AZ2','DFW-DSE-AZ3');
if [ "$ENV_NAME" != "PROD" ] && [ "$ENV_NAME" != "CLIENTTEST" ] && [ "$ENV_NAME" != "DEVINT" ]; then
  echo "\$ENV_NAME is not set!";
  echo "Environment options are PROD, CLIENTTEST or DEVINT";
  exit 1;
fi;

source $P_ROOT/properties/properties.dsecassandra.$ENV_NAME
source config-dse.$ENV_NAME

echo "Datastax requires a passphrase for Gazzang"

read -s -p "Gazzang Passphrase: " GAZZANG_PASSPHASE


# Set FQDN
FQDN=$HOST_NAME.$DOMAIN

#===========================================

echo "BEGIN PROVISION:	$FQDN";

#if [ $OS_FIXED_IP ]; then

#  echo "Fixed IP usage not yet implemented.";
#  exit 1;

#  echo "Using Fixed IP:	$OS_FIXED_IP";


BOOT_STRING="boot_instance=\`nova --insecure boot \
    --flavor \"$OS_FLAVOR\" \
    --image \"$OS_IMAGE\" \
    --nic \"net-id=$OS_NETWORK\" \
    --availability-zone "$AVAIL_ZONE" \
    --security-groups \"$OS_SECURITY_GROUPS\" \
    --key_name \"$OS_KEYNAME\" \
    --user-data \"$P_ROOT/scripts/default.sh\" \
    \"$HOST_NAME\"\`"


echo "BOOT_STRING:$BOOT_STRING"

#  nova --insecure boot \
#    --flavor "$OS_FLAVOR" \
#    --image "$OS_IMAGE" \
#    --nic "net-id=$OS_NETWORK,v4-fixed-ip=$OS_FIXED_IP" \
#    --security-groups "$OS_SECURITY_GROUPS" \
#    --availability-zone "$AVAIL_ZONE" \
#    --key_name "$OS_KEYNAME" \
#    --user-data "$P_ROOT/scripts/default.sh" \
#    --poll "$HOST_NAME"

  boot_instance=`nova --insecure boot \
    --flavor "$OS_FLAVOR" \
    --image "$OS_IMAGE" \
    --nic "net-id=$OS_NETWORK" \
    --security-groups "$OS_SECURITY_GROUPS" \
    --key_name "$OS_KEYNAME" \
    --availability-zone "$AVAIL_ZONE" \
    --user-data "$P_ROOT/scripts/default.sh" \
    "$HOST_NAME"`

  OS_UUID=`echo $boot_instance | sed 's/^.* id / id /'|cut -d\| -f2|sed 's/ //g'|sort`

echo "Sleeping 90 seconds..";
sleep 90;

echo -e "Created $FQDN \n  uuid \"$OS_UUID\"";

#===========================================

# Create Required Volumes
#echo "Creating volumes..";

#vol1id=`nova --insecure volume-create --display-name "$HOST_NAME-u01" 10 | grep " id "| cut -d\| -f3 | sed 's/ //g' | sort`
#echo "created volume.. $vol1id";

#sleep 15;

#vol2id=`nova --insecure volume-create --display-name "$HOST_NAME-u02" 50 | grep " id "| cut -d\| -f3 | sed 's/ //g' | sort`
#echo "created volume.. $vol2id";

# Attach Volumes
#echo "sleeping 60 seconds.. waiting for volumes to become available";
#sleep 60;

#nova --insecure volume-attach $OS_UUID $vol1id /dev/vdc

#sleep 15;

#nova --insecure volume-attach $OS_UUID $vol2id /dev/vdd

#===========================================

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

if (($third_octet='Property') || ($fourth_octet='Property')); then
    echo "Invalid IP address assigned.  Exiting..";
    exit 1;
fi;

#===========================================

ssh_string="-i $P_ROOT/certs/$ENV_PK_NAME -o StrictHostKeyChecking=no cloud-user@$PAT_IPADDR -p $ssh_port"
#ssh_string="-i $P_ROOT/certs/$ENV_PK_NAME  cloud-user@$PAT_IPADDR -p $ssh_port"
root_string="-i $P_ROOT/certs/$ENV_PK_NAME  root@$PAT_IPADDR -p $ssh_port"
scp_string="-i $P_ROOT/certs/$ENV_PK_NAME  -P $ssh_port"

#===========================================

echo "SSH_STRING:$ssh_string";
echo "ROOT_STRING:$root_string";
echo "SCP_STRING:$scp_string";


# Create the new partitions
#echo "Rebooting the server"
#ssh $ssh_string "sudo reboot"
#sleep 60;
#ssh $ssh_string "sudo ls -al"
ssh $ssh_string "sudo bash -c 'cat > /root/p.table << \"EOF\"
# partition table of /dev/vda
unit: sectors

/dev/vda1 : start=     2048,  size= 31457280,    Id=83, bootable
/dev/vda2 : start= 31459328,  size= 10470322,    Id=83
/dev/vda3 : start= 41929650,  size= 94381875,    Id=83
/dev/vda4 : start= 136311525, size= 4158650160,  Id=83
EOF'"

##

ssh $ssh_string "sudo /sbin/lvextend /dev/mapper/vg1-lv_varlog -l+100%FREE";
ssh $ssh_string "sudo /sbin/resize2fs /dev/mapper/vg1-lv_varlog";

ssh $ssh_string "sudo bash -c \"/sbin/sfdisk /dev/vda < /root/p.table --force\""
ssh $ssh_string "sudo /sbin/partx -a /dev/vda"

#ssh $ssh_string "sudo mkdir /u01"
#ssh $ssh_string "sudo mkdir /u02"
#ssh $ssh_string "sudo bash -c \"/sbin/mkfs.ext4 /dev/vdc\""
#ssh $ssh_string "sudo bash -c \"/sbin/mkfs.ext4 /dev/vdd\""
#ssh $ssh_string "sudo mount -t ext4 /dev/vdc /u01"
#ssh $ssh_string "sudo mount -t ext4 /dev/vdd /u02"

echo "Rebooting the server"
ssh $ssh_string "sudo reboot"
sleep 60;
#===========================================

# Install and configure Gazzang

ssh $ssh_string "/usr/bin/wget http://mirror-fpt-telecom.fpt.net/fedora/epel/6/i386/epel-release-6-8.noarch.rpm";
ssh $ssh_string "sudo /usr/bin/yum -y install /home/cloud-user/epel-release-6-8.noarch.rpm";
scp $scp_string $P_ROOT/scripts/gazzang_install.sh cloud-user@$PAT_IPADDR:
ssh $ssh_string "chmod +x gazzang_install.sh";
ssh $ssh_string "sudo ./gazzang_install.sh $GAZZANG_PASSPHASE"

#install alertlogic threatmanager agent
#ssh $ssh_string "/usr/bin/wget -q ftp://netservices-01.dfw.3mhis.vm/pub/soa/rpms/al-threat-host_LATEST.x86_64.rpm"
#ssh $ssh_string "sudo rpm -i /home/cloud-user/al-threat-host_LATEST.x86_64.rpm"
#ssh $ssh_string "sudo /etc/init.d/al-threat-host provision --key 00c69ea46bf6f030ebb6411f17231c822ad4fa2cea6905a831 --inst-type host"
#ssh $ssh_string "sudo /etc/init.d/al-threat-host start"


#install alertlogic logmanager agent
#ssh $ssh_string "/usr/bin/wget -q ftp://netservices-01.dfw.3mhis.vm/pub/soa/rpms/al-log-agent-LATEST-1.x86_64.rpm"
#ssh $ssh_string "sudo rpm -i /home/cloud-user/al-log-agent-LATEST-1.x86_64.rpm"
#ssh $ssh_string "sudo /etc/init.d/al-log-agent provision --key 00c69ea46bf6f030ebb6411f17231c822ad4fa2cea6905a831 --inst-type host"
#ssh $ssh_string "sudo /etc/init.d/al-log-agent start"
#ssh $ssh_string "sudo echo '*.* @@72.32.163.12:443;RSYSLOG_FileFormat' |sudo tee -a /etc/rsyslog.conf"
#ssh $ssh_string "sudo /sbin/service rsyslog restart"

RSYSLOG_CMD="sudo echo '*.* @@72.32.163.12:443;RSYSLOG_FileFormat' >> /etc/rsyslog.conf"
echo "$SYSLOG_CMD:$RSYSLOG_CMD"


# Gazzang should now be installed. Let's prepare the volumes

ssh $ssh_string "sudo /bin/dd if=/dev/zero of=/dev/vda3 ibs=1M count=1"
ssh $ssh_string "sudo /bin/dd if=/dev/zero of=/dev/vda4 ibs=1M count=1"

ssh $ssh_string "sudo mkdir /u01"
ssh $ssh_string "sudo mkdir /u02"

ssh $ssh_string "sudo printf "$GAZZANG_PASSPHASE" | sudo /usr/sbin/zncrypt-prepare /dev/vda3 /u01"
ssh $ssh_string "sudo printf "$GAZZANG_PASSPHASE" | sudo /usr/sbin/zncrypt-prepare /dev/vda4 /u02"


#===========================================

echo -e "\n\n\n== BREAK POINT ==

IP ADDRESS: $instance_ipaddr
SSH PORT: $ssh_port\n";

#read -p "Check the instance and hit [RETURN] to continue..."

#===========================================

# Volumes should now be prepared and mounted - activate with zTrustee
ssh $ssh_string "sudo zncrypt request-activation -c root@dfwprgzgcho01.rs.3mhis.net"

# Clean out the newly mounted directories
ssh $ssh_string "sudo rm -rf /u01/*; sudo rm -rf /u02/*";


#ssh $ssh_string "sudo echo '$instance_ipaddr $FQDN $HOST_NAME' | sudo tee -a /etc/hosts"
#ssh $ssh_string "sudo /etc/init.d/network restart"

#----------

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
ssh $ssh_string "sudo hostname $FQDN"

#----------


# Create the node within Puppet Dashboard
ssh -i $P_ROOT/certs/puppet_key.pem puppetworker@puppet-console.3mhis.vm \
"/opt/puppet/bin/rake -f /opt/puppet/share/puppet-dashboard/Rakefile \
node:add name='$FQDN' groups='default,mcollective,$PUPPET_GROUPS'"

ssh -i $P_ROOT/certs/puppet_key.pem puppetworker@puppet-console.3mhis.vm "sudo puppet node clean $FQDN"

# Install Puppet
scp $scp_string $P_ROOT/scripts/puppet.sh cloud-user@$PAT_IPADDR:
ssh $ssh_string "chmod +x puppet.sh;";
ssh $ssh_string "sudo ./puppet.sh";

#===========================================

sleep 5;

ssh -i $P_ROOT/certs/puppet_key.pem puppetworker@puppet-console.3mhis.vm "sudo puppet cert sign $FQDN"

sleep 5;

ssh $ssh_string "printf \"$GAZZANG_PASSPHASE\" | sudo /usr/sbin/zncrypt acl --add --rule=\"ALLOW @* * *\"";

ssh $ssh_string "sudo /bin/sed -i 's/^.* ssh-rsa /ssh-rsa / ' /root/.ssh/authorized_keys";


ssh $root_string "/opt/puppet/bin/puppet agent -t --environment SOA_SANDBOX; \
		  sleep 15; \
		  printf \"$GAZZANG_PASSPHASE\" | /usr/sbin/zncrypt acl --add --rule=\"ALLOW @data * /usr/java/jdk1.7.0_51/bin/java\"; \
		  printf \"$GAZZANG_PASSPHASE\" | /usr/sbin/zncrypt acl --add --rule=\"ALLOW @saved_caches * /usr/java/jdk1.7.0_51/bin/java\"; \
		  printf \"$GAZZANG_PASSPHASE\" | /usr/sbin/zncrypt acl --add --rule=\"ALLOW @commitlog * /usr/java/jdk1.7.0_51/bin/java\"; \
		  printf \"$GAZZANG_PASSPHASE\" | /usr/sbin/zncrypt acl --del --rule=\"ALLOW @* * *\"";

#===========================================

echo -e "


#===========================================

 Instance Created

 Name: $FQDN
 IP Address: $instance_ipaddr

 PAT IP Address: $PAT_IPADDR
 SSH Port: $ssh_port

  ssh $USER@$PAT_IPADDR -p $ssh_port

#===========================================

";
