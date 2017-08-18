#!/bin/bash

api="sgden1"
environment="SGQA"
zone="az-aurora-01"
hosts=( "nlpwkb-qa-20001" )
flavors=( "0dd08a6b-cb38-48c8-9ede-cf881b85590f" )

for ((i=0;i<${#hosts[@]};++i))
  do
    echo "[INFO]: Provisioning '${hosts[i]}'"
    ./make_default.sh -a ${api} -h ${hosts[i]} -z ${zone} -e ${environment} -s ${flavors[i]} &>sg-builds/${hosts[i]}.out &
  done
exit 0
