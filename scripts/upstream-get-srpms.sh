#!/bin/bash
wget -c -nv -m ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6Client/en/os/SRPMS/ -a sync.log
wget -c -nv -m ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6ComputeNode/en/os/SRPMS/ -a sync.log
wget -c -nv -m ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6Server/en/os/SRPMS/ -a sync.log
wget -c -nv -m ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6Workstation/en/os/SRPMS/ -a sync.log

hardlink -cv ftp.redhat.com &>> sync.log
