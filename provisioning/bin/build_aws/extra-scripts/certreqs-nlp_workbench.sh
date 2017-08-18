#!/bin/bash

cert_host=nlpworkbench
cert_domain=aws.3mhis.net
cert_sdlcs="qa ct pr"

# Get the Dir
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

validate_creds () {
if [ -f "${DIR}/../aws-params/${sdlc}-app.conf" ]
then
  source $DIR/../aws-params/${sdlc}-app.conf
  aws_regions=$(${aws_cli_base} ec2 describe-regions)
  if [ $? -ne 0 ]
  then
    echo "Credentials for ${sdlc} invalid, please verify they exist and correct in $AWS_CONFIG_FILE"
    exit 5
  fi
else
  echo "No known sdlc '${sdlc}'; Please check '${DIR}/aws-params/' for a matching .conf file"
  exit 1
fi
}


for i in ${cert_sdlcs}; do
sdlc=$i
cert_req=${cert_host}.soa-${sdlc}.${cert_domain}
echo "Requesting Cert for: \'${cert_req}\'"
validate_creds
echo "${aws_cli_base} acm request-certificate --domain-name \"${cert_req}\""
done

