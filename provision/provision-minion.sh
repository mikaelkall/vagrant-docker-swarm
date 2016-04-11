#!/bin/sh

TOKEN=8a70b087fa3d3430471dd1672070dec4

if [ -z "${1}" ]; then
    echo "Usage: ${0} <address>"
    exit
fi

address=${1}
name=${2}

# Setup docker-machine 
curl -sL https://github.com/docker/machine/releases/download/v0.6.0/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine && \
chmod +x /usr/local/bin/docker-machine

# Setup ssh keys
cat /vagrant/keys/ssh_host_rsa_key.pub >> /home/docker/.ssh/authorized_keys
chmod 600 /home/docker/.ssh/authorized_keys
