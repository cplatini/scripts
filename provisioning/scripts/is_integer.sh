###########################################
# FUNCTION: is_integer
# DESCRIPTION: Check vaule is not empty 
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

# Check if variables are integers
if ( ! is_integer ${third_octet} ) || ( ! is_integer ${fourth_octet} ); then
  echo "Invalid IP address assigned, exiting. [ Failed ]"
  exit 1
fi