#!/bin/bash
##########################################################
# Make default: It's possible to invoke this script with command-line arguments.
#
#    Example: ./make_engine_nlp.sh -a [API_NAME] -h [HOST_NAME] -z [AVAIL_ZONE] -e [ENV_NAME] -s [VM_TYPE]
#
# Environment Details
# Updated: Tue Jun 30 17:14:19 UTC 2015
# Current NLPD Engines: 220
# Current NLPR Engines: 4
##########################################################
## TO DO: 
## DONE, UPDATED
## Deployed an additional 20 NLPD engines
## NLPD Engine count  updated to 220 engines
##########################################################
######NLPD#####
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00001 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00001.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00002 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00002.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00003 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00003.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00004 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00004.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00005 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00005.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00006 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00006.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00007 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00007.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00008 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00008.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00009 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00009.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00010 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00010.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00011 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00011.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00012 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00012.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00013 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00013.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00014 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00014.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00015 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00015.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00016 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00016.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00017 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00017.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00018 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00018.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00019 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00019.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00020 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00020.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00021 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00021.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00022 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00022.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00023 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00023.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00024 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00024.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00025 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00025.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00026 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00026.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00027 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00027.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00028 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00028.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00029 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00029.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00030 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00030.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00031 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00031.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00032 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00032.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00033 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00033.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00034 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00034.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00035 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00035.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00036 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00036.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00037 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00037.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00038 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00038.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00039 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00039.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00040 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00040.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00041 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00041.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00042 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00042.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00043 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00043.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00044 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00044.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00045 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00045.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00046 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00046.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00047 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00047.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00048 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00048.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00049 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00049.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00050 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00050.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00051 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00051.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00052 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00052.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00053 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00053.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00054 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00054.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00055 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00055.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00056 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00056.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00057 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00057.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00058 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00058.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00059 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00059.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00060 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00060.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00061 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00061.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00062 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00062.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00063 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00063.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00064 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00064.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00065 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00065.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00066 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00066.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00067 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00067.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00068 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00068.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00069 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00069.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00070 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00070.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00071 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00071.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00072 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00072.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00073 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00073.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00074 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00074.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00075 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00075.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00076 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00076.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00077 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00077.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00078 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00078.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00079 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00079.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00080 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00080.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00081 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00081.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00082 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00082.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00083 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00083.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00084 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00084.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00085 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00085.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00086 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00086.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00087 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00087.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00088 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00088.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00089 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00089.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00090 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00090.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00091 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00091.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00092 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00092.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00093 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00093.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00094 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00094.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00095 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00095.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00096 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00096.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00097 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00097.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00098 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00098.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00099 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00099.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00100 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00100.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00101 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00101.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00102 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00102.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00103 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00103.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00104 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00104.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00105 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00105.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00106 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00106.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00107 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00107.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00108 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00108.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00109 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00109.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00110 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00110.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00111 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00111.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00112 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00112.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00113 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00113.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00114 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00114.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00115 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00115.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00116 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00116.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00117 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00117.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00118 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00118.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00119 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00119.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00120 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00120.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00121 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00121.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00122 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00122.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00123 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00123.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00124 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00124.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00125 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00125.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00126 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00126.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00127 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00127.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00128 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00128.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00129 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00129.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00130 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00130.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00131 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00131.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00132 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00132.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00133 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00133.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00134 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00134.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00135 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00135.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00136 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00136.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00137 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00137.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00138 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00138.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00139 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00139.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00140 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00140.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00141 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00141.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00142 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00142.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00143 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00143.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00144 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00144.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00145 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00145.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00146 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00146.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00147 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00147.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00148 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00148.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00149 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00149.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00150 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00150.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00151 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00151.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00152 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00152.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00153 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00153.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00154 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00154.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00155 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00155.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00156 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00156.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00157 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00157.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00158 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00158.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00159 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00159.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00160 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00160.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00161 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00161.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00162 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00162.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00163 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00163.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00164 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00164.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00165 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00165.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00166 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00166.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00167 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00167.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00168 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00168.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00169 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00169.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00170 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00170.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00171 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00171.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00172 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00172.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00173 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00173.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00174 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00174.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00175 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00175.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00176 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00176.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00177 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00177.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00178 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00178.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00179 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00179.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00180 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00180.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00181 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00181.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00182 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00182.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00183 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00183.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00184 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00184.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00185 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00185.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00186 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00186.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00187 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00187.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00188 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00188.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00189 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00189.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00190 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00190.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00191 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00191.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00192 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00192.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00193 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00193.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00194 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00194.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00195 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00195.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00196 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00196.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00197 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00197.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00198 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00198.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00199 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00199.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00200 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00200.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00201 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00201.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00202 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00202.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00203 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00203.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00204 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00204.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00205 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00205.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00206 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00206.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00207 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00207.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00208 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00208.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00209 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00209.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00210 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00210.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00211 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00211.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00212 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00212.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00213 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00213.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00214 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00214.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00215 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00215.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00216 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00216.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00217 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00217.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00218 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00218.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00219 -z AZ-PR-STANDARD-2 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00219.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-PR-00220 -z AZ-PR-STANDARD-1 -e PROD -s NLPD  &>nlp-build-out/nlpd-pr-00220.out &

######NLPR#####

#./make_engine_nlp.sh -a raxdfw -h NLPR-PR-00001 -z AZ-PR-STANDARD-1 -e PROD -s NLPR  &>nlp-build-out/nlpr-pr-00001.out &
#./make_engine_nlp.sh -a raxdfw -h NLPR-PR-00002 -z AZ-PR-STANDARD-2 -e PROD -s NLPR  &>nlp-build-out/nlpr-pr-00002.out &
#./make_engine_nlp.sh -a raxdfw -h NLPR-PR-00003 -z AZ-PR-STANDARD-1 -e PROD -s NLPR  &>nlp-build-out/nlpr-pr-00003.out &
#./make_engine_nlp.sh -a raxdfw -h NLPR-PR-00004 -z AZ-PR-STANDARD-2 -e PROD -s NLPR  &>nlp-build-out/nlpr-pr-00004.out &

###### NLPQ #####
## NLPR Queue
# ./make_engine_nlp.sh -a raxdfw -h NLPRQ-PR-00001 -z AZ-NP-STANDARD-1 -e PROD -s NLPQ  &>nlp-build-out/nlprq-pr-00001.out &
# ./make_engine_nlp.sh -a raxdfw -h NLPRQ-PR-00002 -z AZ-NP-STANDARD-2 -e PROD -s NLPQ  &>nlp-build-out/nlprq-pr-00002.out &
# ## NLPD Queue
# ./make_engine_nlp.sh -a raxdfw -h NLPDQ-PR-00001 -z AZ-NP-STANDARD-1 -e PROD -s NLPQ  &>nlp-build-out/nlpdq-pr-00001.out &
# ./make_engine_nlp.sh -a raxdfw -h NLPDQ-PR-00002 -z AZ-NP-STANDARD-2 -e PROD -s NLPQ  &>nlp-build-out/nlpdq-pr-00002.out &