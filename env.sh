#!/bin/bash
echo "[I] Pointing docker to manager: 192.168.3.1:3376"
export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.3.1:3376"
export DOCKER_CERT_PATH="/home/nighter/dev/vagrant-docker-swarm/keys"
export DOCKER_MACHINE_NAME="master"
