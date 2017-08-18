#!/bin/bash
###
#
# Basic Engine Boot Script
#   For AWS
# By Richard
#
# Version: alpha
#
# Usage:
# ./{script-name} [number of nodes] [node id to start on]
# 
# Example:
# ./aws-engine-boot.sh 50 30001
#   This will build 50 nodes starting at ID 30001 and ending at 30050
#
###

## Global Vars
nodes=$1
id_start=$2
sdlc="pr"
nlp_repo_url="http://yum-bg-30001.sys.aws.3mhis.net/prod"
aws_ami_1="ami-c23001a8"
aws_ami_2="ami-c33001a9"
aws_subnet_1="subnet-fb8377d1"
aws_subnet_2="subnet-fb8377d1"
aws_group="sg-61e18618"
aws_vpc="vpc-ad4f3fc9"
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
  #We need to alternate AMI's used and potentially subnets (AZs)
  if (( $node % 2 == 0 ))
    then
      aws_ami="${aws_ami_2}"
      aws_subnet=$(ec2-describe-subnets -F tag:Name=nlp-priv* | grep SUBNET | awk '{ print $2,$6 }' | sort -k2 -n | tail -n 1 | awk '{ print $1 }')
    else
      aws_ami="${aws_ami_1}"
      aws_subnet=$(ec2-describe-subnets -F tag:Name=nlp-priv* | grep SUBNET | awk '{ print $2,$6 }' | sort -k2 -n | tail -n 1 | awk '{ print $1 }')
  fi
  echo "[Info] Prepping user_data for node "${hostname}-${node}""
  prep_userdata
  echo "[Info] Cleaning up for node "${hostname}-${node}""
  pre_boot
  echo "[Info] Booting node "${hostname}-${node}""
  boot_instance
  if (( $node % 10 == 0 )); then echo "[Info] Sleeping(60s) between batches of 10"; sleep 60; fi
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
yum-config-manager --disable {base,updates,epel,extras}
rm /etc/yum.repos.d/puppetlabs.repo
printf "[aws-base]\\\nname=aws-base\\\nbaseurl=http://yum-bg-30001.sys.aws.3mhis.net/base\\\nenabled=1\\\ngpgcheck=0\\\n" | tee /etc/yum.repos.d/aws-base.repo
printf "[aws-updates]\\\nname=aws-base\\\nbaseurl=http://yum-bg-30001.sys.aws.3mhis.net/updates\\\nenabled=1\\\ngpgcheck=0\\\n" | tee /etc/yum.repos.d/aws-updates.repo
printf "[aws-epel]\\\nname=aws-epel\\\nbaseurl=http://yum-bg-30001.sys.aws.3mhis.net/epel\\\nenabled=1\\\ngpgcheck=0\\\n" | tee /etc/yum.repos.d/aws-epel.repo
printf "[nlp_engine_repo]\\\nbaseurl=${nlp_repo_url}\\\nenabled=1\\\ngpgcheck=0\\\n" | tee /etc/yum.repos.d/nlp_engine_repo.repo
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
echo "[Info]: Attempting to Delete old instance"
ec2-terminate-instances $(ec2-describe-instances -F tag:Name=${hostname}-${node} | grep INSTANCE | grep -v terminated | awk '{ print $2}')
}

boot_instance () {
## Boot the instance and the the ID
aws_instance_boot=$(ec2-run-instances ${aws_ami} -t ${flavor} --tenancy dedicated -k 'rldehaven@mmm.com' -f $DIR/${hostname}-${node}.sh -a :0:${aws_subnet}:::${aws_group})
echo -e "aws_instance_boot=\n"${aws_instance_boot}""
## Get the Instance ID from the boot output
aws_instance_id=$(echo "${aws_instance_boot}" | grep "INSTANCE" | awk '{ print $2 }')
## Remove the user-data file since we've booted already
rm $DIR/${hostname}-${node}.sh
sleep 5
## Tag the instance using the ID
ec2-create-tags ${aws_instance_id} --tag "Name=${hostname}-${node}" --tag "Stack=${sdlc}" --tag "Requestor=A3SDAZZ" --tag "Role=NLPD"
}



## NLPDs
hostname="nlpd-${sdlc}"
flavor="r3.xlarge"
build_vms $nodes $id_start

