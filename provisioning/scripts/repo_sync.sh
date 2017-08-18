#!/bin/bash
###########################################
# DEBUGGING
###########################################
# /bin/sh (usually is a sybolic link to bash)
# /usr/bin/bash
# /usr/bin/env bash
# Debugging: set -x
# set -x   # Print a trace of simple commands and their arguments
###########################################
# SCRIPT INFORMATION
###########################################
## wget -m -np -nH --cut-dirs=100 -r -P /repo/prod/ http://fileservices-01.dfw.3mhis.vm/yum/3MHIS/prod/
## CT
sudo wget -m -nH --cut-dirs=100 -r -np -A "*.rpm" -P /repo/client_test/ "http://fileservices-01.dfw.3mhis.vm/yum/3MHIS/client_test/"
cd /repo/client_test
rm -rf ./repodata
createrepo .
## Prod
sudo wget -m -nH --cut-dirs=100 -r -np -A "*.rpm" -P /repo/prod/ "http://fileservices-01.dfw.3mhis.vm/yum/3MHIS/prod/"
cd /repo/prod
rm -rf ./repodata
createrepo .