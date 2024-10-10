#!/bin/bash
ip_address=$1

if ! [[ $ip_address =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
  echo "IP address is not correct"
  exit 1
fi

octets=( $(echo $ip_address | tr '.' ' ') )

binary_ip=""
for octet in "${octets[@]}"; do
  binary_octet=$(echo "obase=2; $octet" | bc)
  binary_octet=$(printf "%08d" $binary_octet)
  binary_ip="$binary_ip$binary_octet."
  if [[ $octet > 255 ]]; then
    echo "IP address is not correct"
    exit 1
  fi
done

binary_ip=${binary_ip%?}

echo "Binary IP address: $binary_ip"
