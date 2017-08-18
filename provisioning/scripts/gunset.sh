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
gunset()
{
  local var_re="${1:-.*}"
  eval $( set | \
        awk -v FS='='        \
            -v VAR="$var_re" \
            '$1 ~ VAR { print "unset", $1 }' )
}
# Set variables
VAR1=value1
VAR2=value2
VAR3=value3
VAR4=value4

# Testing variables
echo "Vars before gunset"
set | grep ^VAR
gunset 'VAR.*'
echo "Vars after gunset"
set | grep ^VAR