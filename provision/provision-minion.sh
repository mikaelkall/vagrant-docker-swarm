#!/bin/sh

# We need to disable tls in docker.
export DOCKER_TLS=no

if [ -z "${1}" ]; then
    echo "Usage: ${0} <address>"
    exit
fi

# Start docker
/etc/init.d/docker start
sleep 3

address=${1}
name=${2}

docker run --name ${name} -d swarm join --addr=${address}:2375 token://8a70b087fa3d3430471dd1672070dec4
