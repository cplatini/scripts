###########################################
# FUNCTION: is_integer
# DESCRIPTION: Check value is not empty 
# Try to print the value using printf
###########################################
function is_integer() {
  # Check value is not empty and a number
  if [[ -n "$1" ]]; then
      printf "%d" $1 > /dev/null 2>&1
      return $?
  fi
  # return 1, not a number
  return 1
}
###########################################
# FUNCTION: is_empty
# DESCRIPTION: Check value is empty 
###########################################
function is_empty() {
  # Check value is not empty and a number
  if [[ -z "$1" ]]; then
      # return 0, is empty
      return 0
  fi
  # return 1, not empty
  return 1
}
###########################################
# CHECK INSTANCE IP ADDRESS
# Check for proper IP address (May still be building)
# Attempt to find the IP address 3 times before failing
###########################################
echo -e "Checking for a valid IPv4 address."
ip_check='1'
ip_check_count='0'
# Ensure we get a value that isn't empty
while [ "${ip_check}" != 0 ]; do
  # Get the instance's IP by OS_UUID and store it
  instance_ipaddr=$(nova --insecure show ${OS_UUID} | grep -i "network" | awk -F'|' '{print $3}' | xargs echo -n)
  # Check for an empty string
  if ( ! is_empty ${instance_ipaddr} ); then
    # not empty, break
    ip_check='0'
    break
  else #set, this is empty
    ip_check='1'
  fi

  let "ip_check_count+=1"
  if [ "${ip_check_count}" -lt 3 ]; then
    sleep 30
  else
    echo "***ERROR: Couldn't get the Host's IP after ${ip_check_count} checks*** [ Failed ]"
    nova --insecure delete "${OS_UUID}"
    echo "Deleted failed instance: \"${OS_UUID}\" "
    exit 1
  fi
done
# Ensure we get an IP address or delete the instance
third_octet=$(echo ${instance_ipaddr} | awk -F'.' '{print $3}' | xargs echo -n)
fourth_octet=$(echo ${instance_ipaddr} | awk -F'.' '{print $4}' | xargs echo -n)
# Check if variables are integers
if ( ! is_integer ${third_octet} ) || ( ! is_integer ${fourth_octet} ); then
  echo "Illegal IP address: not a number. [ Failed ]"
  nova --insecure delete "${OS_UUID}"
  echo "Deleted failed instance: \"${OS_UUID}\" "
  exit 1
fi
# Ensure the fourth octet isn't 0 or 255
# This depends, and would be valid in a /16 subnet, 255,255.0.0
# The network address (.0) and the network broadcast address (.255)
t_network_id='0'
t_braodcast_id='255'
if [ "${fourth_octet}" -eq "${t_network_id}" ] || [ "${fourth_octet}" -eq "${t_braodcast_id}" ]; then
  echo "Illegal IP address: fourth octet contains (0) or (255). [ Failed ]"
  nova --insecure delete "${OS_UUID}"
  echo "Deleted failed instance: \"${OS_UUID}\" "
  exit 1
fi