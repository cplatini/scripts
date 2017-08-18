#Config File for an app
#
#
# Author: Richard DeHaven
# Version: 0.0.1
# Date: 2016-03-18
# Application: YUM-Sandbox

## Set the app specific Vars
aws_group="sg-997bc5e1"
aws_flavor="m2.medium"
aws_datadisk_gb="250"
role="Yum Server"

## Prep the 'UserData' Function for the main script
prep_userdata () {
###
# We can replace ${node} with $(/usr/bin/facter -p ec2_instance_id)
# for use in Cloud Formation Templates, or Multi-Launch Wizard)
###
read -d '' aws_userdata <<__EOF__
#!/bin/bash
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
pvresize /dev/xvdf
lvextend -l +100%FREE /dev/mapper/vg_ebs-srv
resize2fs /dev/mapper/vg_ebs-srv
printf "\\\n\\\n### Bind-mount /srv to /var/www\\\n/srv     /var/www   none  bind  0 0\\\n" | tee -a /etc/fstab
mount -a
echo "\$(facter -p ipaddress) ${hostname}-${node}.${domain} ${hostname}-${node}" | tee -a /etc/hosts
sed -i "s/HOSTNAME=.*/HOSTNAME=${hostname}-${node}.${domain}/" /etc/sysconfig/network
hostname ${hostname}-${node}
echo '10.18.49.21        puppet-master-30001.di.aws.3mhis.net' | tee -a /etc/hosts
ntpdate -u 10.18.49.149

yum -y erase puppet-agent puppetlabs-release-pc1.noarch
yum -y install createrepo redhat-lsb
yum -y update pam curl

curl -k https://puppet-master-30001.di.aws.3mhis.net:8140/packages/current/install.bash | bash -s agent:pluginsignore=.svn

/usr/bin/reposync --repoid=base --download_path=/var/www/yum && createrepo --update /var/www/yum/base
/usr/bin/reposync --repoid=updates --download_path=/var/www/yum && createrepo --update /var/www/yum/updates
/usr/bin/reposync --repoid=epel --download_path=/var/www/yum && createrepo --update /var/www/yum/epel
__EOF__

echo "${aws_userdata}" > $DIR/${hostname}-${node}.sh
}
