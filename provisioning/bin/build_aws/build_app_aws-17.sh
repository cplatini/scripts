#!/bin/bash
###
#
# Build Script for AWS Apps
#
# Author: Richard DeHaven
# Version: 0.1.2
# Date: 2016-04-01
#
###

# Get the Dir
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

AWS_CONFIG_FILE=$HOME/.aws/credentials

## Global Vars
nodes=$1
id_start=$2
sdlc=$3
app=$4
domain="soa-${sdlc}.aws.3mhis.net"

# Pull in some vars and functions from other locations
## Source the AMI Info
source $DIR/aws-params/ami-standard.conf
## Source the Environment Info
if [ -f "${DIR}/aws-params/${sdlc}-app.conf" ]
then
  source $DIR/aws-params/${sdlc}-app.conf
  aws_regions=$(${aws_cli_base} ec2 describe-regions)
  if [ $? -ne 0 ]
  then
    echo "Credentials for ${sdlc} invalid, please verify they exist and correct in $AWS_CONFIG_FILE"
    exit 5
  fi
else
  echo "No known sdlc '${sdlc}'; Please check '${DIR}/aws-params/' for a matching .conf file"
  exit 1
fi
## Source the App Info
if [ -f "${DIR}/apps/${app}17.app" ]
then
  source ${DIR}/apps/${app}17.app
else
  echo "No known app '${app}17'; Please check '${DIR}/apps/' for a matching .app file"
  exit 1
fi

build_vms () {
# $1 is 'Number of VMs'
# $2 is 'Starting Serial#'

node=$2

for (( i=1; i <= $nodes ; i++ ))
do
  #We need to alternate subnets (AZs)
  if (( $node % 2 == 0 ))
    then
      aws_subnet=$(${aws_cli_base} ec2 describe-subnets --subnet --filter "Name=tag:Name,Values=${aws_subnet_fltr}" --query "Subnets[*].[SubnetId, AvailableIpAddressCount]" | sort -k2 -n | tail -n 1 | awk '{ print $1 }')
    else
      aws_subnet=$(${aws_cli_base} ec2 describe-subnets --subnet --filter "Name=tag:Name,Values=${aws_subnet_fltr}" --query "Subnets[*].[SubnetId, AvailableIpAddressCount]" | sort -k2 -n | tail -n 1 | awk '{ print $1 }')
  fi
  echo "[Info] Prepping user_data for node "${hostname}-${node}-17""
  prep_userdata
  echo "[Info] Cleaning up for node "${hostname}-${node}-17""
  pre_boot
  echo "[Info] Booting node "${hostname}-${node}-17""
  boot_instance
  if (( $node % 10 == 0 )); then echo "[Info] Sleeping(60s) between batches of 10"; sleep 60; fi
  node=$((node+1))
  if (( $nodes > 10 )); then echo "[Info] Sleeping between nodes on large deployment"; sleep 5; fi
done
}

pre_boot () {
## Clean old node from puppet
ssh_puppet_console="-q -i $DIR/../../certs/puppet_key.pem -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null puppetworker@puppet-master-01.sys.raxdfw.3mhis.net";
ssh ${ssh_puppet_console} 'bash -s' <<__ENDSSH__
  sudo puppet cert clean ${hostname}-${node}-17.${domain}
  echo "[DONE]"
__ENDSSH__

## Clean old instance
aws_old_instance=$(${aws_cli_base} ec2 describe-instances --filters "Name=tag:Name,Values=${hostname}-${node}-17" "Name=instance-state-name,Values='running'" --query "Reservations[*].Instances[*].[InstanceId]")
if [ "${aws_old_instance}" != "" ]
then
  echo "[Info]: Attempting to Delete old instance"
  ${aws_cli_base} ec2 terminate-instances --instance-ids ${aws_old_instance}
  if [ "${aws_elb_name}" != "" ]
  then
    ${aws_cli_base} elb deregister-instances-from-load-balancer --load-balancer-name ${aws_elb_name} --instances ${aws_old_instance}
  fi
fi
}

boot_instance () {
## Boot the instance and the the ID
aws_instance_boot=$(${aws_cli_base} ec2 run-instances --image-id ${aws_ami} --instance-type ${flavor} --placement Tenancy=${aws_tenancy} --user-data file://${DIR}/${hostname}-${node}-17.sh --security-group-ids ${aws_group} --subnet-id ${aws_subnet} --iam-instance-profile Name=${sdlc}-linux-automation --block-device-mappings '[{"DeviceName":"/dev/xvdf","Ebs":{"VolumeSize":'${aws_datadisk_gb}'}},{"DeviceName":"/dev/sda1","Ebs":{"VolumeSize":'${aws_rootdisk_gb}'}}]')
echo -e "aws_instance_boot=\n"${aws_instance_boot}""

## Get the Instance ID from the boot output
aws_instance_id=$(echo "${aws_instance_boot}" | grep "INSTANCES" | awk '{ print $7 }')

## Remove the user-data file since we've booted already
#rm $DIR/${hostname}-${node}-17.sh
sleep 5

## Tag the instance using the ID
${aws_cli_base} ec2 create-tags --resources ${aws_instance_id} --tags Key=Name,Value=${hostname}-${node}-17 Key=Requestor,Value=A3SDAZZ Key=Role,Value=${role} Key=Deployment,Value=${sdlc}

## Add to loadbalancer if necessary
if [ "${aws_elb_name}" != "" ]
then
  echo [Info] Attempting to add ${hostname}-${node}-17 to Load-Balancer ${aws_elb_name}
  ${aws_cli_base} elb register-instances-with-load-balancer --load-balancer-name ${aws_elb_name} --instances ${aws_instance_id}
fi
}


## Build the nodes
hostname="${app}-${sdlc}"
flavor="${aws_flavor}"
build_vms $nodes $id_start

