#!/bin/sh
TOKEN=8a70b087fa3d3430471dd1672070dec4

if [ -z "${1}" ]; then
    echo "Usage: ${0} <addresses>"
    exit
fi

addresses=${1}

# Install docker-machine 
curl -sL https://github.com/docker/machine/releases/download/v0.6.0/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine && \
chmod +x /usr/local/bin/docker-machine

# Install ssh keys
cat /vagrant/keys/ssh_host_rsa_key.pub >> /home/docker/.ssh/authorized_keys
chmod 600 /home/docker/.ssh/authorized_keys

# Provision master
echo "Provision: master [192.168.3.1]"
docker-machine create --generic-ssh-key=/vagrant/keys/ssh_host_rsa_key --driver generic --swarm --swarm-master --swarm-discovery token://${TOKEN} --generic-ssh-user docker --generic-ip-address 192.168.3.1 master
echo "eval \$(docker-machine env master --swarm)" >> /root/.profile

# Provision minions
IFS=','
i=0
for address in ${addresses};
do
    i=$((i + 1))
    name="minion-$i"
    echo "Provision: ${name} [${address}]" 
    docker-machine create --generic-ssh-key=/vagrant/keys/ssh_host_rsa_key --driver generic --swarm --swarm-discovery token://${TOKEN} --generic-ssh-user docker --generic-ip-address ${address} ${name} 
done
