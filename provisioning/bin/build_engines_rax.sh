#!/bin/bash

## Global Vars
api="raxdfw"
environment="CLIENTTEST"
sdlc="ct"
az_base="AZ-CT-STANDARD"
make_script="make_default_rax.sh"
make_out_dir="nlp-build-out"

build_vms () {
# $1 is 'Number of VMs'
# $2 is 'Starting Serial#'

unset node
node=$2

for (( i=1; i <= $1 ; i++ ))
do
### Alternate AZs ###
  nodemod=$((10#$node + 2))
  tmp=$((nodemod % 2))
  if [ $tmp -eq 0 ]
  then
    az_id="2"
  else
    az_id="1"
  fi
### Specific AZ ###
#  az_id="03"
###
  echo "[INFO]: Building \"${hostname}-${node}\" in AZ:\"${az_base}-${az_id}\" with flavor \"${flavor}\".  Log:\"${make_out_dir}/${hostname}-${node}.out\""
  ./${make_script} -a ${api} -h ${hostname}-${node} -z ${az_base}-${az_id} -e ${environment} -s ${flavor} &>${make_out_dir}/${hostname}-${node}.out &
  node=`printf "%0${#node}d\n" $((10#$node+1))`
  if (( $1 > 10 )); then sleep 60; fi
done
}

## NLPDs
hostname="nlpd-${sdlc}"
flavor="NLPD"
build_vms 49 00002

## NLPRs
#hostname="nlpr-${sdlc}"
#flavor="NLPR"
#build_vms 4 00001
