#!/bin/bash
# Preparação básica para Kubernetes

# Atualização do sistema
dnf update -y

# Instala ferramentas essenciais
dnf install -y curl wget vim net-tools git bash-completion

# Desativa SELinux
setenforce 0
sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config

# Desativa swap (obrigatório para Kubernetes)
swapoff -a
sed -i '/swap/d' /etc/fstab

# Ativa módulos necessários
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
cat <<EOF | tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sysctl --system

# Instala containerd
dnf install -y containerd
mkdir -p /etc/containerd
containerd config default | tee /etc/containerd/config.toml
systemctl enable --now containerd

# Adiciona repositório Kubernetes
cat <<EOF | tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.29/rpm/repodata/repomd.xml.key
EOF

# Instala kubelet, kubeadm e kubectl
dnf install -y kubelet kubeadm kubectl
systemctl enable --now kubelet

