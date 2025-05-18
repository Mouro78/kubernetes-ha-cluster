#!/bin/bash
# Atualização do sistema
dnf update -y

# Instala ferramentas essenciais
dnf install -y curl wget vim net-tools git bash-completion

# Desativa SELinux
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config

# Configura hostnames e hosts
echo "192.168.68.200 haproxy" >> /etc/hosts
echo "192.168.68.201 master1" >> /etc/hosts
echo "192.168.68.202 master2" >> /etc/hosts
echo "192.168.68.203 worker1" >> /etc/hosts
echo "192.168.68.204 worker2" >> /etc/hosts

