#!/bin/bash
sudo kubeadm join 172.31.21.228:6443 --token z1zd2k.ozxtaos48pa4yh5h \
	--discovery-token-ca-cert-hash sha256:5eb41ce6f9ad033ed6595c3ee86bb08465340b27a1bef3fdb693bf62e8329352 
