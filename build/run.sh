#!/bin/bash

# Setup ssh root user password
if [ -z $SSHPASSWORD ]; then
  SSHPASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)
  echo "SSHUSER:$SSHPASSWORD" | chpasswd
  echo "SSH PASSWORD is: $SSHPASSWORD"
else
  echo "root:$SSHPASSWORD" | chpasswd
fi

# Generate ssh host keys.
ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
