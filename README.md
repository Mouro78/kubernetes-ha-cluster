# Cluster Kubernetes com Alta Disponibilidade no Rocky Linux 9.5

Este repositório contém scripts e configurações para implementar um cluster Kubernetes com alta disponibilidade usando Rocky Linux 9.5, HAProxy, e Calico CNI.

## Arquitetura

O cluster é composto por:

- **HAProxy**: Balanceador de carga (192.168.68.200)
- **Master1**: Primeiro nó control-plane (192.168.68.201)
- **Master2**: Segundo nó control-plane (192.168.68.202)
- **Worker1**: Primeiro nó worker (192.168.68.203)
- **Worker2**: Segundo nó worker (192.168.68.204)

## Componentes Implementados

- Kubernetes v1.29
- HAProxy como balanceador de carga
- Calico CNI para networking
- Nginx como aplicação de teste
- Prometheus e Grafana para monitorização
