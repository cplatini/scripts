# Setting up hosts and resolv file, and configuring the network
echo -e "Setting up the hosts and resolv file, and configuring the network."
ssh ${ssh_string} 'bash -s' <<__ENDSSH__
  echo "Adding FQDN in/etc/hosts"
  sudo echo "${instance_ipaddr} ${FQDN} ${HOST_NAME}" | sudo tee -a /etc/hosts
  echo "Adding netservices, fileservices, and puppet to /etc/hosts"
  sudo echo '172.16.180.254 netservices-01.dfw.3mhis.vm' | sudo tee -a /etc/hosts
  sudo echo '172.16.180.191 fileservices-01.dfw.3mhis.vm' | sudo tee -a /etc/hosts
  sudo echo '172.16.180.16 puppet-console.sys.raxdfw.3mhis.net' | sudo tee -a /etc/hosts
  sudo echo '172.16.180.127 puppet-master-01.sys.raxdfw.3mhis.net' | sudo tee -a /etc/hosts
  echo "Adding nameserver to /etc/resolv.conf"
  sudo echo 'nameserver 172.16.180.254' | sudo tee -a /etc/resolv.conf
  echo "Fixing dhclient to ensure nameserver"
  sudo echo 'prepend domain-name-servers 172.16.180.254;' | sudo tee -a /etc/dhcp/dhclient-eth0.conf
  sudo echo "supersede domain-name \"$SDLC_DOMAIN\";" | sudo tee -a /etc/dhcp/dhclient-eth0.conf
  echo "Restart network"
  sudo /etc/init.d/network restart
  echo "[ DONE ]"
__ENDSSH__