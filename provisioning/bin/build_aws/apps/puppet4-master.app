#Config File for an app
#
#
# Author: Richard DeHaven, Nicholas Houle 
# Version: 0.0.7
# Date: 2016-03-16
# Application: Puppet4-Master

## Overwrite some core Vars
aws_subnet_fltr="*VPC-MGMT Private*"
aws_env_fltr="PR"
aws_vpc="vpc-2f6d9d48"

## Set the app specific Vars
aws_group=$(${aws_cli_base} ec2 describe-security-groups --filter Name=group-name,Values="*${aws_env_fltr}-PuppetMaster-App*" --query 'SecurityGroups[*].GroupId')
aws_flavor="m4.xlarge"
aws_rootdisk_gb="200"
aws_datadisk_gb="200"
aws_elb_name=""
role="Puppet4-Master"

## Prep the 'UserData' Function for the main script
prep_userdata () {
###
# We can replace ${node} with $(/usr/bin/facter -p ec2_instance_id)
# for use in Cloud Formation Templates, or Multi-Launch Wizard)
###
read -d '' aws_userdata <<__EOF__
#!/bin/bash
setenforce Permissive
echo "\$(facter -p ipaddress) ${hostname}-${node}.${domain} ${hostname}-${node}" | tee -a /etc/hosts
sed -i "s/HOSTNAME=.*/HOSTNAME=${hostname}-${node}.${domain}/" /etc/sysconfig/network
hostname ${hostname}-${node}
pvresize /dev/xvdf
lvextend -l +100%FREE /dev/mapper/vg_ebs-srv
resize2fs /dev/mapper/vg_ebs-srv
printf "\\\n\\\n### Bind-mount /srv to /opt\\\n/srv     /extra   none  bind  0 0\\\n" | tee -a /etc/fstab
mount -a
echo "${yumserver_ip}        ${yumserver_name}" | tee -a /etc/hosts
yum-config-manager --disable {base,updates,epel,extras}
rm /etc/yum.repos.d/puppetlabs.repo
printf "[aws-base]\\\nname=aws-base\\\nbaseurl=http://${yumserver_name}/base\\\nenabled=1\\\ngpgcheck=0\\\n" | tee /etc/yum.repos.d/aws-base.repo
printf "[aws-updates]\\\nname=aws-updates\\\nbaseurl=http://${yumserver_name}/updates\\\nenabled=1\\\ngpgcheck=0\\\n" | tee /etc/yum.repos.d/aws-updates.repo
printf "[aws-epel]\\\nname=aws-epel\\\nbaseurl=http://${yumserver_name}/epel\\\nenabled=1\\\ngpgcheck=0\\\n" | tee /etc/yum.repos.d/aws-epel.repo
yum -y erase puppet puppetlabs-release
yum -y remove java-1.8.0-openjdk-headless java-1.8.0-openjdk-devel java-1.8.0-openjdk
yum -y install redhat-lsb-core java-1.8.0-openjdk-headless
yum -y update pam curl

ntpdate -u ${ntpserver}

useradd -m -G redbox_localLogin,cho-admins rryates-onyx
mkdir /home/rryates-onyx/.ssh
printf "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC2iUqRxn4lPIM1PP0/Op9RPoOGbyG/QLTpHF9i4M03BOyvDEn8wRnzFO4E2f1FgMDs5GtOg/+lot74L20/E0ZVYuKE1c0oMv6HL64sS3vTD1OVY6p/WyR78i1Q0XJ/wGx/i/gNY+VflDs6KmZk3Ar2ryRAXTOpisqZpmDGt28ND5v0vPr1fULfcQ4uaz5IYAh++zMDHLhiDLdFq2ZaTOB1pAPjAf8x2Ase6qLVgzs3BGqxI9utvwAGVaUiCWdSZcU+A9wbpjG5srIfGfQXwIPvEXE/ig4K0P3kXSx4ljwl0sL2BKh9bMC7NYG7BSOHXrQIg3GoGrsnThgnnS9UGCj96MdEhB8A4GPny/j6zEUtbypnWb3uL5xS0REafu8PQKhaHgDOeeJnS0tdnWHfYOsNFQDh+mCm5gXx2CKwdzNjS0YLxKjhbLos9jNqYlrfQSpNccsEph/7cksMy31u3USuOD+FXUbCfp3w9wExrQVzwHULTUVU0i2DVBC0x7MsWW6RxiRRCq3W54haZAV1nbzDY4S4KYcqbZa+w8/A1H6EcwcOgftlcbxxSF3CxGXfM0Qa5JRZQ7AZuXCL4uwj4Hnm3CPFxr/5IICiKpZAwJUQgWV8bNFE97RpvmF8wb1t/uOXqz6u3XkToP4cOvUDaf/nNYGE6Vlvdv3aEpvqMcUJFw== ryan.russell-yates@onyxpoint.com-20161108" | tee /home/rryates-onyx/.ssh/authorized_keys
chown -R rryates-onyx:rryates-onyx /home/rryates-onyx/.ssh
chmod -R 0600 /home/rryates-onyx/.ssh/authorized_keys
__EOF__

echo "${aws_userdata}" > $DIR/${hostname}-${node}.sh
}
