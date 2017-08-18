#!/bin/bash
##########################################################
# Make cluster: It's possible to invoke this script with command-line arguments.
#
#    Example: ./sg_make_cluster_elsearch.sh -a [API_NAME] -h [HOST_NAME] -z [AVAIL_ZONE] -e [ENV_NAME] -s [VM_TYPE]
#
# Environment Details
# Updated: Thu Aug 20 18:05:15 UTC 2015
# Current ELSEARCH KWB: 4
# Current ELSEARCH LOGGING: 0
##########################################################
## TO DO:
## Nothing to do for DI right now
##########################################################

###### ELSEARCH KWB CLIENT #####
#./sg_make_cluster_elsearch.sh -a sgden1 -h ELSEARCH-KWB-DI-CLIENT-20001 -z az-aurora-03 -e SGDI -s ELSEARCHKWB  &>elsearch-build-out/elsearch-kwb-di-client-20001.out &

###### ELSEARCH KWB MASTER #####
#./sg_make_cluster_elsearch.sh -a sgden1 -h ELSEARCH-KWB-DI-MASTER-20001 -z az-aurora-03 -e SGDI -s ELSEARCHKWB  &>elsearch-build-out/elsearch-kwb-di-master-20001.out &

###### ELSEARCH KWB DATA #####
#./sg_make_cluster_elsearch.sh -a sgden1 -h ELSEARCH-KWB-DI-DATA-20001 -z az-aurora-03 -e SGDI -s ELSEARCHKWB  &>elsearch-build-out/elsearch-kwb-di-data-20001.out &

###### ELSEARCH KWB MARVEL CLUSTER #####
#./sg_make_cluster_elsearch.sh -a sgden1 -h ELSEARCH-KWB-DI-MARVEL-20001 -z az-aurora-03 -e SGDI -s ELSEARCHKWB  &>elsearch-build-out/elsearch-kwb-di-marvel-20001.out &


##########################################################
###### ELSEARCH LOGGING  #####
#./sg_make_cluster_elsearch.sh -a sgden1 -h ELSEARCH-LOG-DI-20001 -z az-aurora-03 -e SGDI -s ELSEARCHLOG  &>elsearch-build-out/elsearch-log-di-20001.out &
#./sg_make_cluster_elsearch.sh -a sgden1 -h ELSEARCH-LOG-DI-20002 -z az-aurora-03 -e SGDI -s ELSEARCHLOG  &>elsearch-build-out/elsearch-log-di-20002.out &
#./sg_make_cluster_elsearch.sh -a sgden1 -h ELSEARCH-LOG-DI-20003 -z az-aurora-03 -e SGDI -s ELSEARCHLOG  &>elsearch-build-out/elsearch-log-di-20003.out &

