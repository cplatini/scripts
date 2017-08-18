#!/bin/bash
# install puppet

echo "nameserver 172.16.180.254" > /etc/resolv.conf

cd /root

wget -q "ftp://netservices-01.dfw.3mhis.vm/puppet/puppet-enterprise-3.7.2-el-6-x86_64.tar.gz"

tar zxf puppet-enterprise-3.7.2-el-6-x86_64.tar.gz

cd puppet-enterprise-3.7.2-el-6-x86_64

cat > answers.txt << EOF
q_all_in_one_install=n
q_database_install=n
q_fail_on_unsuccessful_master_lookup=y
q_install=y
q_puppet_cloud_install=n
q_puppet_enterpriseconsole_install=n
q_puppetagent_certname=$(hostname -f)
q_puppetagent_install=y
q_puppetagent_server=puppet-master-01.sys.raxdfw.3mhis.net
q_puppetca_hostname=puppet-master-01.sys.raxdfw.3mhis.net
q_puppetca_install=n
q_puppetdb_install=n
q_puppetmaster_enterpriseconsole_certname=$(hostname -f)
q_puppetmaster_install=n
q_run_updtvpkg=n
q_vendor_packages_install=y
EOF

sudo ./puppet-enterprise-installer -a answers.txt
