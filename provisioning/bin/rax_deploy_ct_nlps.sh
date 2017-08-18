#!/bin/bash
##########################################################
# Make default: It's possible to invoke this script with command-line arguments.
#
#    Example: ./make_engine_nlp.sh -a [API_NAME] -h [HOST_NAME] -z [AVAIL_ZONE] -e [ENV_NAME] -s [VM_TYPE]
#
# Environment Details
# Updated: Wed May 20 15:45:58 UTC 2015
# Current NLPD Engines: 200
# Current NLPR Engines: 4
# Current NLP Queues: 4
##########################################################
## TO DO:
## Deploy an additional 20 NLPD engines, if approved.
## If approved, NLPD Engine count needs to be updated to 220 engines
##########################################################
######NLPD#####
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00001 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00001.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00002 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00002.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00003 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00003.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00004 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00004.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00005 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00005.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00006 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00006.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00007 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00007.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00008 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00008.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00009 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00009.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00010 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00010.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00011 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00011.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00012 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00012.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00013 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00013.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00014 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00014.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00015 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00015.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00016 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00016.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00017 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00017.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00018 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00018.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00019 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00019.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00020 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00020.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00021 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00021.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00022 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00022.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00023 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00023.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00024 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00024.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00025 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00025.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00026 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00026.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00027 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00027.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00028 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00028.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00029 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00029.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00030 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00030.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00031 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00031.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00032 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00032.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00033 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00033.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00034 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00034.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00035 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00035.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00036 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00036.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00037 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00037.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00038 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00038.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00039 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00039.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00040 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00040.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00041 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00041.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00042 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00042.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00043 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00043.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00044 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00044.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00045 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00045.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00046 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00046.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00047 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00047.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00048 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00048.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00049 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00049.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00050 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00050.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00051 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00051.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00052 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00052.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00053 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00053.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00054 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00054.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00055 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00055.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00056 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00056.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00057 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00057.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00058 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00058.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00059 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00059.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00060 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00060.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00061 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00061.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00062 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00062.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00063 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00063.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00064 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00064.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00065 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00065.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00066 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00066.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00067 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00067.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00068 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00068.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00069 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00069.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00070 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00070.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00071 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00071.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00072 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00072.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00073 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00073.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00074 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00074.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00075 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00075.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00076 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00076.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00077 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00077.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00078 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00078.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00079 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00079.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00080 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00080.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00081 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00081.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00082 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00082.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00083 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00083.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00084 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00084.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00085 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00085.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00086 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00086.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00087 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00087.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00088 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00088.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00089 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00089.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00090 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00090.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00091 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00091.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00092 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00092.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00093 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00093.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00094 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00094.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00095 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00095.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00096 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00096.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00097 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00097.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00098 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00098.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00099 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00099.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00100 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00100.out &

##############################################################
#### DO NOT DEPLOY MORE THAN 100 AS OF 9/26/2015 -Richard ####
##############################################################

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00101 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00101.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00102 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00102.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00103 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00103.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00104 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00104.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00105 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00105.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00106 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00106.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00107 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00107.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00108 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00108.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00109 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00109.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00110 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00110.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00111 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00111.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00112 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00112.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00113 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00113.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00114 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00114.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00115 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00115.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00116 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00116.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00117 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00117.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00118 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00118.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00119 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00119.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00120 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00120.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00121 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00121.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00122 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00122.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00123 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00123.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00124 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00124.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00125 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00125.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00126 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00126.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00127 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00127.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00128 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00128.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00129 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00129.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00130 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00130.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00131 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00131.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00132 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00132.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00133 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00133.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00134 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00134.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00135 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00135.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00136 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00136.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00137 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00137.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00138 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00138.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00139 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00139.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00140 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00140.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00141 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00141.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00142 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00142.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00143 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00143.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00144 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00144.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00145 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00145.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00146 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00146.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00147 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00147.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00148 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00148.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00149 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00149.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00150 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00150.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00151 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00151.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00152 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00152.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00153 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00153.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00154 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00154.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00155 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00155.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00156 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00156.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00157 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00157.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00158 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00158.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00159 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00159.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00160 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00160.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00161 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00161.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00162 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00162.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00163 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00163.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00164 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00164.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00165 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00165.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00166 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00166.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00167 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00167.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00168 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00168.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00169 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00169.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00170 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00170.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00171 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00171.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00172 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00172.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00173 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00173.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00174 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00174.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00175 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00175.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00176 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00176.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00177 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00177.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00178 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00178.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00179 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00179.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00180 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00180.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00181 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00181.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00182 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00182.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00183 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00183.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00184 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00184.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00185 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00185.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00186 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00186.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00187 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00187.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00188 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00188.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00189 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00189.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00190 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00190.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00191 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00191.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00192 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00192.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00193 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00193.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00194 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00194.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00195 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00195.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00196 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00196.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00197 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00197.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00198 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00198.out &
#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00199 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00199.out &

#./make_engine_nlp.sh -a raxdfw -h NLPD-CT-00200 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPD &>nlp-build-out/nlpd-ct-00200.out &

######NLPR#####

#./make_engine_nlp.sh -a raxdfw -h NLPR-CT-00001 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPR &>nlp-build-out/nlpr-ct-00001.out &
#./make_engine_nlp.sh -a raxdfw -h NLPR-CT-00002 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPR &>nlp-build-out/nlpr-ct-00002.out &
#./make_engine_nlp.sh -a raxdfw -h NLPR-CT-00003 -z AZ-CT-STANDARD-1 -e CLIENTTEST -s NLPR &>nlp-build-out/nlpr-ct-00003.out &
#./make_engine_nlp.sh -a raxdfw -h NLPR-CT-00004 -z AZ-CT-STANDARD-2 -e CLIENTTEST -s NLPR &>nlp-build-out/nlpr-ct-00004.out &

###### NLPQ #####
## NLPR Queue
# ./make_engine_nlp.sh -a raxdfw -h NLPRQ-CT-00001 -z AZ-NP-STANDARD-1 -e CLIENTTEST -s NLPQ  &>nlp-build-out/nlprq-ct-00001.out &
# ./make_engine_nlp.sh -a raxdfw -h NLPRQ-CT-00002 -z AZ-NP-STANDARD-2 -e CLIENTTEST -s NLPQ  &>nlp-build-out/nlprq-ct-00002.out &
# ## NLPD Queue
# ./make_engine_nlp.sh -a raxdfw -h NLPDQ-CT-00001 -z AZ-NP-STANDARD-1 -e CLIENTTEST -s NLPQ  &>nlp-build-out/nlpdq-ct-00001.out &
# ./make_engine_nlp.sh -a raxdfw -h NLPDQ-CT-00002 -z AZ-NP-STANDARD-2 -e CLIENTTEST -s NLPQ  &>nlp-build-out/nlpdq-ct-00002.out &
