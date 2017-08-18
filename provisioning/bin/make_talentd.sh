#!/bin/bash

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

if [ "$ENV_NAME" != "PROD" ] && [ "$ENV_NAME" != "CLIENTTEST" ] && [ "$ENV_NAME" != "DEVINT" ] && [ "$ENV_NAME" != "QA" ] && [ "$ENV_NAME" != "DI2" ]; then
  echo "\$ENV_NAME is not set!";
  echo "Environment options are PROD, CLIENTTEST, QA, DI2 or DEVINT";
  exit 1;
fi;

source $P_ROOT/properties/properties.dsecassandra.$ENV_NAME
source config-dse.$ENV_NAME

#echo "Datastax requires a passphrase for Gazzang"

#read -s -p "Gazzang Passphrase: " GAZZANG_PASSPHASE


# Set FQDN
FQDN=$HOST_NAME.$DOMAIN

#===========================================

echo "BEGIN PROVISION:	$FQDN";

#if [ $OS_FIXED_IP ]; then

#  echo "Fixed IP usage not yet implemented.";
#  exit 1;

#  echo "Using Fixed IP:	$OS_FIXED_IP";

OS_FLAVOR='c4a90b09-c304-42ce-9561-5caffd49ce53'
OS_NETWORK='98039f9f-88f9-4aae-9cee-c76dc0d51ce6'
PAT_IPADDR='72.3.199.166'
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

#ssh $ssh_string "sudo bash -c 'cat > /root/p.table << \"EOF\"
# partition table of /dev/vda
#unit: sectors

#/dev/vda1 : start=     2048,  size= 31457280,    Id=83, bootable
#/dev/vda2 : start= 31459328,  size= 10470322,    Id=83
#/dev/vda3 : start= 41929651,  size= 83886080,    Id=83
#/dev/vda4 : start= 125815731, size= 2147483648,  Id=83
#EOF'"

##

ssh $ssh_string "sudo /sbin/lvextend /dev/mapper/vg1-lv_varlog -l+100%FREE";
ssh $ssh_string "sudo /sbin/resize2fs /dev/mapper/vg1-lv_varlog";

ssh $ssh_string "sudo bash -c \"/sbin/sfdisk /dev/vda < /root/p.table --force\""
ssh $ssh_string "sudo /sbin/partx -a /dev/vda"

# Install and configure Gazzang

#ssh $ssh_string "/usr/bin/wget http://mirror-fpt-telecom.fpt.net/fedora/epel/6/i386/epel-release-6-8.noarch.rpm";
#ssh $ssh_string "sudo /usr/bin/yum -y install /home/cloud-user/epel-release-6-8.noarch.rpm";
#scp $scp_string $P_ROOT/scripts/gazzang_install.sh cloud-user@$PAT_IPADDR:
#ssh $ssh_string "chmod +x gazzang_install.sh";
#ssh $ssh_string "sudo ./gazzang_install.sh $GAZZANG_PASSPHASE"


RSYSLOG_CMD="sudo echo '*.* @@72.32.163.12:443;RSYSLOG_FileFormat' >> /etc/rsyslog.conf"
echo "$SYSLOG_CMD:$RSYSLOG_CMD"


# Gazzang should now be installed. Let's prepare the volumes

#ssh $ssh_string "sudo /bin/dd if=/dev/zero of=/dev/vda3 ibs=1M count=1"
#ssh $ssh_string "sudo /bin/dd if=/dev/zero of=/dev/vda4 ibs=1M count=1"

#ssh $ssh_string "sudo mkdir /u01"
#ssh $ssh_string "sudo mkdir /u02"

#ssh $ssh_string "sudo printf "$GAZZANG_PASSPHASE" | sudo /usr/sbin/zncrypt-prepare /dev/vda3 /u01"
#ssh $ssh_string "sudo printf "$GAZZANG_PASSPHASE" | sudo /usr/sbin/zncrypt-prepare /dev/vda4 /u02"


#===========================================

echo -e "\n\n\n== BREAK POINT ==

IP ADDRESS: $instance_ipaddr
SSH PORT: $ssh_port\n";

#read -p "Check the instance and hit [RETURN] to continue..."

#===========================================

# Volumes should now be prepared and mounted - activate with zTrustee
#ssh $ssh_string "sudo zncrypt request-activation -c root@dfwprgzgcho01.rs.3mhis.net"

# Clean out the newly mounted directories
#ssh $ssh_string "sudo rm -rf /u01/*; sudo rm -rf /u02/*";


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

#ssh $ssh_string "printf \"$GAZZANG_PASSPHASE\" | sudo /usr/sbin/zncrypt acl --add --rule=\"ALLOW @* * *\"";

ssh $ssh_string "sudo /bin/sed -i 's/^.* ssh-rsa /ssh-rsa / ' /root/.ssh/authorized_keys";
ssh $ssh_string "sudo sed -i.bak 's/production/SOA_SANDBOX/g' /etc/puppetlabs/puppet/puppet.conf"
ssh $ssh_string "sudo /usr/local/bin/puppet agent --test"


#ssh $root_string "/opt/puppet/bin/puppet agent -t --environment SOA_SANDBOX; \
#		  sleep 15; \
#		  printf \"$GAZZANG_PASSPHASE\" | /usr/sbin/zncrypt acl --add --rule=\"ALLOW @data * /usr/java/jdk1.7.0_51/bin/java\"; \
#		  printf \"$GAZZANG_PASSPHASE\" | /usr/sbin/zncrypt acl --add --rule=\"ALLOW @saved_caches * /usr/java/jdk1.7.0_51/bin/java\"; \
#		  printf \"$GAZZANG_PASSPHASE\" | /usr/sbin/zncrypt acl --add --rule=\"ALLOW @commitlog * /usr/java/jdk1.7.0_51/bin/java\"; \
#		  printf \"$GAZZANG_PASSPHASE\" | /usr/sbin/zncrypt acl --del --rule=\"ALLOW @* * *\"";

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
