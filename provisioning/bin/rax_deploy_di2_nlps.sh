#!/bin/bash
##########################################################
# Make default: It's possible to invoke this script with command-line arguments.
#
#    Example: ./make_engine_nlp.sh -a [API_NAME] -h [HOST_NAME] -z [AVAIL_ZONE] -e [ENV_NAME] -s [VM_TYPE]
#
# Environment Details
# Updated: Mon Dec 21 16:51:04 UTC 2015
# Current NLPD Engines: 2
# Current NLPR Engines: 2
# Current NLPQ Engines: 2
# Current NLPKWB Engines: 1
##########################################################
## TO DO:
## Nothing to do for DI2 right now
##########################################################
###### NLPD #####
#./rax_make_engine_nlps.sh -a raxdfw -h NLPD-DI2-00001 -z AZ-NP-STANDARD-1 -e DI2 -s NLPD  &>nlp-build-out/nlpd-di2-00001.out &
#./rax_make_engine_nlps.sh -a raxdfw -h NLPD-DI2-00002 -z AZ-NP-STANDARD-2 -e DI2 -s NLPD  &>nlp-build-out/nlpd-di2-00002.out &

###### NLPR #####
#./rax_make_engine_nlps.sh -a raxdfw -h NLPR-DI2-00001 -z AZ-NP-STANDARD-1 -e DI2 -s NLPR  &>nlp-build-out/nlpr-di2-00001.out &
#./rax_make_engine_nlps.sh -a raxdfw -h NLPR-DI2-00002 -z AZ-NP-STANDARD-2 -e DI2 -s NLPR  &>nlp-build-out/nlpr-di2-00002.out &

###### NLPQ #####
#./rax_make_engine_nlps.sh -a raxdfw -h NLPRQ-DI2-00001 -z AZ-NP-STANDARD-1 -e DI2 -s NLPQ  &>nlp-build-out/nlprq-di2-00001.out &
#./rax_make_engine_nlps.sh -a raxdfw -h NLPDQ-DI2-00001 -z AZ-NP-STANDARD-2 -e DI2 -s NLPQ  &>nlp-build-out/nlpdq-di2-00001.out &

##########################################################
##########################################################
###### NLP KWB #######
#./rax_make_engine_nlps.sh -a raxdfw -h nlpkwb-di2-00001 -z AZ-NP-STANDARD-1 -e DI2 -s NLPKWB &>nlp-build-out/nlpkwb-di2-00001.out &
