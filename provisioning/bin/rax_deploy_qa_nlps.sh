#!/bin/bash
##########################################################
# Make default: It's possible to invoke this script with command-line arguments.
#
#    Example: ./make_engine_nlp.sh -a [API_NAME] -h [HOST_NAME] -z [AVAIL_ZONE] -e [ENV_NAME] -s [VM_TYPE]
#
# Environment Details
# Updated: Tue Jun 30 17:14:19 UTC 2015
# Current NLPD Engines: 20
# Current NLPR Engines: 2
##########################################################
## TO DO:
## Update naming convention
## Deploy an additional 20 NLPD engines, if approved.
## If approved, NLPD Engine count needs to be updated to 40 engines
##########################################################
######NLPD#####
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00001 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00001.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00002 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00002.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00003 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00003.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00004 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00004.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00005 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00005.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00006 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00006.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00007 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00007.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00008 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00008.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00009 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00009.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00010 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00010.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00011 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00011.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00012 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00012.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00013 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00013.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00014 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00014.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00015 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00015.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00016 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00016.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00017 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00017.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00018 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00018.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00019 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00019.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00020 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00020.out &

# If approved, increase document engines to 40
# Wed May 20 15:49:18 UTC 2015

#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00021 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00021.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00022 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00022.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00023 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00023.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00024 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00024.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00025 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00025.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00026 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00026.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00027 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00027.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00028 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00028.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00029 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00029.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00030 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00030.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00031 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00031.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00032 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00032.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00033 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00033.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00034 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00034.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00035 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00035.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00036 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00036.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00037 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00037.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00038 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00038.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00039 -z AZ-NP-STANDARD-1 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00039.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-QA-00040 -z AZ-NP-STANDARD-2 -e QA -s NLPD &>nlp-build-out/nlpd-qa-00040.out &

###### NLPR #####

#./make_engine_nlp.sh -a raxdfw -h NLPR-QA-00001 -z AZ-NP-STANDARD-1 -e QA -s NLPR &>nlp-build-out/nlpr-qa-00001.out &
#./make_engine_nlp.sh -a raxdfw -h NLPR-QA-00002 -z AZ-NP-STANDARD-2 -e QA -s NLPR &>nlp-build-out/nlpr-qa-00002.out &

###### NLPQ #####
./make_engine_nlp.sh -a raxdfw -h NLPRQ-QA-00001 -z AZ-NP-STANDARD-1 -e QA -s NLPQ  &>nlp-build-out/nlprq-qa-00001.out &
./make_engine_nlp.sh -a raxdfw -h NLPDQ-QA-00001 -z AZ-NP-STANDARD-2 -e QA -s NLPQ  &>nlp-build-out/nlpdq-qa-00001.out &

