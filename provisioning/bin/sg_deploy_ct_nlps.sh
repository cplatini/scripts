#!/bin/bash
##########################################################
# Make default: It's possible to invoke this script with command-line arguments.
#
#    Example: ./sg_make_engine_nlp.sh -a [API_NAME] -h [HOST_NAME] -z [AVAIL_ZONE] -e [ENV_NAME] -s [VM_TYPE]
#
# Environment Details
# Updated: Wed Nov  4 20:06:35 UTC 2015
# Current NLPD Engines: 0
# Current NLPR Engines: 0
# Current NLPD Queues: 0
# Current NLPR Queues: 0
# Current NLP KWB: 1
##########################################################
## TO DO:
## Nothing to do for CT right now
##########################################################
######################
######## NLPD ########
#./sg_make_engine_nlps.sh
#./sg_make_engine_nlps.sh

######################
######## NLPR ########
#./sg_make_engine_nlps.sh
#./sg_make_engine_nlps.sh

##########################################################
##########################################################
###### NLPR Queue #####
#./sg_make_engine_nlps.sh

###### NLPD Queue #####
#./sg_make_engine_nlps.sh

##########################################################
##########################################################
###### NLP KWB #######
#./sg_make_engine_nlps.sh -a sgden1 -h nlpkwb-ct-20001 -z az-aurora-03 -e SGCT -s NLPKWB  &>nlp-build-out/nlpkwb-ct-20001.out &