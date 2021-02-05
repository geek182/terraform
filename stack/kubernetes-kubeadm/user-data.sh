#!/bin/bash

sysctl -p
apt-get update
apt-get install -y docker.io

apt-get update && apt-get install -y apt-transport-https curl
curl -4 -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

echo $(kubectl version)
