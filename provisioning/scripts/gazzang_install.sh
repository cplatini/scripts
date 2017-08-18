#!/bin/bash -x
#Gazzang zNcrypt Install Script

GAZZANG_PASSPHASE="$1"
TRUSTEE_SERVER="dfwprgzgcho01.rs.3mhis.net"
ZNCRYPT_RESTORE="false"

#check if gazzang is already installed
if [ -f "/etc/init.d/zncrypt-mount" ]
then 
    echo "zncrypt client has already been installed";
    exit 0;
fi

set -e


#Create or update the /etc/yum.repos.d/gazzang.repo file to add entries as follows
  
cat >  /etc/yum.repos.d/gazzang.repo << "EOF"
[gazzang-stable]
name=RHEL $releasever - gazzang.com
baseurl=http://archive.gazzang.com/redhat/stable/6Server/
enabled=1
gpgcheck=1
gpgkey=http://archive.gazzang.com/gpg_gazzang.asc
EOF

#This version is causing conflicts with the required version.
yum -y remove gnutls-2.8.5-10.el6_4.1

yum -y install kernel-devel haveged python-argparse pytz gnutls-utils m2crypto mod_proxy_html mod_ssl mod_wsgi postgresql postgresql-server postgresql-libs python-psycopg2 pyOpenSSL

# Start haveged service
service haveged start

#Import the GPG key used to sign the package
rpm --import http://archive.gazzang.com/gpg_gazzang.asc
   
   
# correct path to headers
new_header=`uname -a | awk '{ print $3 }'`
old_header=`ls /usr/src/kernels`
if [ "$new_header" != "$old_header" ];then
  ln -s /usr/src/kernels/$old_header /usr/src/kernels/$new_header
fi
#Use the yum utility to install the zTrustee components
yum -y install zncrypt-3.3.0_rhel6-734.x86_64 zncrypt-kernel-module-3.3.0_rhel6-734.x86_64

if [ ! $TRUSTEE_SERVER ];then
echo "Missing TRUSTEE_SERVER input"
fi

if [ "$ZNCRYPT_RESTORE" == "false" ];then
printf "$GAZZANG_PASSPHASE\n$GAZZANG_PASSPHASE" | /usr/sbin/zncrypt register \
--skip-ssl-check --key-type=single-passphrase  -s $TRUSTEE_SERVER

fi

#fix bug with centos 6.4
sed -i 's/< \/dev\/tty//' /etc/init.d/zncrypt-mount 



chkconfig --add zncrypt-mount
chkconfig zncrypt-mount on
chkconfig --level 235 haveged on

exit 0
