function validateIP() {
if [ `echo $OS_FIXED_IP | grep -o '\.' | wc -l` -ne 3 ]; then
  echo "'$OS_FIXED_IP' is not a valid IP Address";
  exit 1;
elif [ `echo $OS_FIXED_IP | tr '.' ' ' | wc -w` -ne 4 ]; then
  echo "'$OS_FIXED_IP' is not a valid IP Address";
  exit 1;
else
  for OCTET in `echo $OS_FIXED_IP | tr '.' ' '`; do
    if ! [[ $OCTET =~ ^[0-9]+$ ]]; then
      echo "'$OS_FIXED_IP' is not a valid IP Address";
      exit 1;
    elif [[ $OCTET -lt 0 || $OCTET -gt 255 ]]; then
      echo "'$OS_FIXED_IP' is not a valid IP Address";
      exit 1;
    fi
  done
fi

return 0;
}
