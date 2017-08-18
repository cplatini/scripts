#!/bin/bash
#########################################
# File Name: sws
# Automated Multiple Screen Runner
#########################################
#########################################

## Give a little help

if [ "$1" == "-h" ] || [ "$1" == "--h" ] || [ "$1" == "-help" ] || [ "$1" == "--help" ];
then
  #echo -e "\n\nUsage: `basename $0` [num_sessions] [file_to_run]";
  #echo -e "Example: ./sws 5 script.sh\n\n";
  exit 0
fi

## Get the variables

VAR_ONE=$1;
VAR_TWO=$2;

read -p "Tell me how many VM(s) to create: " NUM_SESSIONS

FILE_TO_RUN="./make_default.sh";
#FILE_TO_RUN="./testvars";

#########################################
#########################################

## Find out the details of the job

echo -e "The application will now create $NUM_SESSIONS Virtual Machine(s)\n";

read -p "Press [ENTER] to begin the process.";

## Initiate the job

for i in {001..027};
do
	H_NAME="$VAR_ONE-$i"
echo	screen -d -m -S sws-screen-$i "$FILE_TO_RUN" "$H_NAME" "$VAR_TWO"
done

#########################################
#########################################

## Show completed message

echo -e "\n===========================================
The application has begun provisioning $NUM_SESSIONS Virtual Machine(s).
Please allow a bit of time for the process to complete.

You can also check for any sws-screen-* sessions.\n\n";

while screen -list | grep -q "sws-screen-*"; do echo -e "Waiting...\n"; sleep 3; done

echo -e "The process has been completed, and the VM(s) should be online any moment.\n\n";

## End of file
