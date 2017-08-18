#Config File for an app
#
#
# Author: Richard DeHaven, Nicholas Houle 
# Version: 0.0.7
# Date: 2017-02-5
# Application: Bastion

## Overwrite some core Vars
aws_subnet_fltr="*DI-MGMT Public Subnet A*"
aws_env_fltr="DI"
aws_vpc="vpc-cf47a5a8"

## Set the app specific Vars
aws_group='sg-866c74fe'
aws_flavor="t2.small"
aws_rootdisk_gb="30"
aws_datadisk_gb="30"
aws_elb_name=""
role="BASTION"
app_id="148"

## Prep the 'UserData' Function for the main script
prep_userdata () {
###
# We can replace ${node} with $(/usr/bin/facter -p ec2_instance_id)
# for use in Cloud Formation Templates, or Multi-Launch Wizard)
###
read -d '' aws_userdata <<__EOF__
#!/bin/bash 
setenforce Permissive
find /etc/selinux/ -name 'config' | xargs sed -i 's/\=enforcing/\=permissive/g'
pvresize /dev/xvdf
lvextend -l +100%FREE /dev/mapper/vg_ebs-srv
resize2fs /dev/mapper/vg_ebs-srv
printf "\\\n\\\n### Bind-mount /srv to /extra\\\n/srv     /extra   none  bind  0 0\\\n" | tee -a /etc/fstab
mount -a
echo "\$(facter -p ipaddress) ${hostname}-${node}.${domain} ${hostname}-${node}" | tee -a /etc/hosts
sed -i "s/HOSTNAME=.*/HOSTNAME=${hostname}-${node}.${domain}/" /etc/sysconfig/network
hostname ${hostname}-${node}
echo "${puppetmaster_ip}        ${puppetmaster_name} puppet" | tee -a /etc/hosts
echo "${yumserver_ip}        ${yumserver_name}" | tee -a /etc/hosts
yum-config-manager --disable {base,updates,epel,extras}
rm /etc/yum.repos.d/puppetlabs.repo
printf "[aws-base]\\\nname=aws-base\\\nbaseurl=http://${yumserver_name}/base\\\nenabled=1\\\ngpgcheck=0\\\n" | tee /etc/yum.repos.d/aws-base.repo
printf "[aws-updates]\\\nname=aws-base\\\nbaseurl=http://${yumserver_name}/updates\\\nenabled=1\\\ngpgcheck=0\\\n" | tee /etc/yum.repos.d/aws-updates.repo
printf "[aws-epel]\\\nname=aws-epel\\\nbaseurl=http://${yumserver_name}/epel\\\nenabled=1\\\ngpgcheck=0\\\n" | tee /etc/yum.repos.d/aws-epel.repo
yum -y erase puppet puppetlabs-release
yum -y remove java-1.8.0-openjdk-headless java-1.8.0-openjdk-devel java-1.8.0-openjdk
yum -y install redhat-lsb java-1.8.0-openjdk-headless
yum -y update pam curl

ntpdate -u ${ntpserver}

curl -k https://puppet:8140/packages/current/install.bash | bash -s agent:pluginsignore=.svn
__EOF__

echo "${aws_userdata}" > $DIR/${hostname}-${node}.sh
}
