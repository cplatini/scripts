#!/bin/bash
###
#
# Basic Engine Boot Script
#   For AWS
# By Richard
#
###

## Global Vars
nodes=$1
id_start=$2
sdlc="pr"
aws_ami="ami-2ce8cf46"
aws_subnet="subnet-6b887c41"
aws_group="sg-e76b0d9e"
aws_vpc="vpc-83b5c5e7"
make_script="make_default_sg.sh"
make_out_dir="nlp-build-out"
domain="${sdlc}.aws.3mhis.net"

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"


build_vms () {
# $1 is 'Number of VMs'
# $2 is 'Starting Serial#'

node=$2

for (( i=1; i <= $nodes ; i++ ))
do
  echo "[Info] Prepping user_data for node "${hostname}-${node}""
  prep_userdata
  echo "[Info] Cleaning up for node "${hostname}-${node}""
  pre_boot
  echo "[Info] Booting node "${hostname}-${node}""
  boot_instance
  node=$((node+1))
  if (( $nodes > 10 )); then echo "[Info] Sleeping between nodes on large deployment"; sleep 5; fi
done
}

prep_userdata () {
###
# We can replace ${node} with $(/usr/bin/facter -p ec2_instance_id)
# for use in Cloud Formation Templates, or Multi-Launch Wizard)
###
read -d '' aws_userdata <<__EOF__
#!/bin/bash 
setenforce Permissive
pvresize /dev/xvdf
lvextend -l +100%FREE /dev/mapper/vg_ebs-srv
resize2fs /dev/mapper/vg_ebs-srv
printf "\\\n\\\n### Bind-mount /srv to /extra\\\n/srv     /extra   none  bind  0 0\\\n" | tee -a /etc/fstab
mount -a
echo "\$(facter -p ipaddress) ${hostname}-${node}.${domain} ${hostname}-${node}" | tee -a /etc/hosts
sed -i "s/HOSTNAME=.*/HOSTNAME=${hostname}-${node}.${domain}/" /etc/sysconfig/network
hostname ${hostname}-${node}
echo '192.168.4.224        puppet-master-01.sys.aws.3mhis.net' | tee -a /etc/hosts
echo '192.168.4.120        yum-bg-30001.sys.aws.3mhis.net' | tee -a /etc/hosts
ntpdate -u 192.168.4.219
curl -k https://puppet-master-01.sys.aws.3mhis.net:8140/packages/current/install.bash | bash -s agent:pluginsignore=.svn
__EOF__

echo "${aws_userdata}" > $DIR/${hostname}-${node}.sh
}

pre_boot () {
## Clean old node from puppet
ssh_puppet_console="-q -i $DIR/../certs/puppet_key.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null puppetworker@puppet-master-01.sys.raxdfw.3mhis.net";
ssh ${ssh_puppet_console} 'bash -s' <<__ENDSSH__
  sudo puppet cert clean ${hostname}-${node}.${domain}
  echo "[DONE]"
__ENDSSH__

## Clean old instance
ec2-terminate-instances $(ec2-describe-instances -F tag:Name=${hostname}-${node} | grep INSTANCE | grep -v terminated | awk '{ print $2}')
}

boot_instance () {
## Boot the instance and the the ID
aws_instance_id=$(ec2-run-instances ${aws_ami} -t ${flavor} --associate-public-ip-address true -f $DIR/${hostname}-${node}.sh -a :0:${aws_subnet}:::${aws_group} -b /dev/xvdf=snap-ed6cc37b:30 | grep 'INSTANCE' | awk '{ print $2}')
rm $DIR/${hostname}-${node}.sh
sleep 5
## Tag the instance using the ID
ec2-create-tags ${aws_instance_id} --tag "Name=${hostname}-${node}" --tag "Stack=${sdlc}" --tag "Requestor=A3SDAZZ" --tag "Role=BASTION"
}



## VarFiller
hostname="bastion-ssh"
flavor="t2.small"
build_vms $nodes $id_start

