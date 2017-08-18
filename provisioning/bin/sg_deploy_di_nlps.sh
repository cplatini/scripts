#!/bin/bash
##########################################################
# Make default: It's possible to invoke this script with command-line arguments.
#
#    Example: ./sg_make_engine_nlp.sh -a [API_NAME] -h [HOST_NAME] -z [AVAIL_ZONE] -e [ENV_NAME] -s [VM_TYPE]
#
# Environment Details
# Updated: Wed Nov  4 20:06:35 UTC 2015
# Current NLPD Engines: 2
# Current NLPR Engines: 2
# Current NLPD Queues: 0
# Current NLPR Queues: 0
# Current NLP KWB: 1
##########################################################
## TO DO:
## Nothing to do for DI right now
##########################################################
######################
######## NLPD ########
#./sg_make_engine_nlps.sh -a sgden1 -h nlpd-di-20001 -z az-aurora-01 -e SGDI -s NLPD  &>nlp-build-out/nlpd-di-20001.out &
#./sg_make_engine_nlps.sh -a sgden1 -h nlpd-di-20002 -z az-aurora-02 -e SGDI -s NLPD  &>nlp-build-out/nlpd-di-20002.out &

######################
######## NLPR ########
#./sg_make_engine_nlps.sh -a sgden1 -h nlpr-di-20001 -z az-aurora-01 -e SGDI -s NLPR  &>nlp-build-out/nlpr-di-20001.out &
#./sg_make_engine_nlps.sh -a sgden1 -h nlpr-di-20002 -z az-aurora-02 -e SGDI -s NLPR  &>nlp-build-out/nlpr-di-20002.out &

##########################################################
##########################################################
###### NLPR Queue #####
#./sg_make_engine_nlps.sh -a sgden1 -h nlprq-di-20001 -z az-aurora-01 -e SGDI -s NLPQ  &>nlp-build-out/nlprq-di-20001.out &

###### NLPD Queue #####
#./sg_make_engine_nlps.sh -a sgden1 -h nlpdq-di-20001 -z az-aurora-02 -e SGDI -s NLPQ  &>nlp-build-out/nlpdq-di-20001.out &

##########################################################
##########################################################
###### NLP KWB #######
#./sg_make_engine_nlps.sh -a sgden1 -h nlpkwb-di-20001 -z az-aurora-03 -e SGDI -s NLPKWB &>nlp-build-out/nlpkwb-di-20001.out &