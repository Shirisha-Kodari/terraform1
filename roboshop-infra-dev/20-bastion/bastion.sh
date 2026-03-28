#!/bin/bash

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

sudo growpart /dev/nvme0n1 4
sudo lvextend -L +10G /dev/RootVG/rootVol
sudo lvextend -L +20G /dev/mapper/RootVG-homeVol

sudo xfs_growfs /
sudo xfs_growfs /home

git clone https://github.com/siri-123706/roboshop-infra-dev.git