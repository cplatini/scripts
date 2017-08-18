#!/bin/bash

## Global Vars
api="sgden1"
environment="SGCT"
sdlc="ct"
az_base="az-aurora"
make_script="make_default_sg.sh"
make_out_dir="nlp-build-out"

build_vms () {
# $1 is 'Number of VMs'
# $2 is 'Starting Serial#'

node=$2

for (( i=1; i <= $1 ; i++ ))
do
### Alternate AZs ###
  tmp=$(( $node % 2 ))
  if [ $tmp -eq 0 ]
  then
    az_id="02"
  else
    az_id="01"
  fi
### Specific AZ ###
#  az_id="03"
###
  echo "[INFO]: Building \"${hostname}-${node}\" in AZ:\"${az_base}-${az_id}\" with flavor \"${flavor}\".  Log:\"${make_out_dir}/${hostname}-${node}.out\""
  ./${make_script} -a ${api} -h ${hostname}-${node} -z ${az_base}-${az_id} -e ${environment} -s ${flavor} &>${make_out_dir}/${hostname}-${node}.out &
  node=$((node+1))
  if (( $1 > 10 )); then sleep 60; fi
done
}

## NLPDs
hostname="nlpd-${sdlc}"
flavor="NLPD"
build_vms 50 20001

## NLPRs
#hostname="nlpr-${sdlc}"
#flavor="NLPR"
#build_vms 2 20001
