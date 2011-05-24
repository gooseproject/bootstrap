all:
	@echo all

control/combined.empty: control/last-sync.empty
	cp -lnu -t combined ftp.redhat.com/pub/redhat/linux/enterprise/6Client/en/os/SRPMS/*.src.rpm
	cp -lnu -t combined ftp.redhat.com/pub/redhat/linux/enterprise/6Workstation/en/os/SRPMS/*.src.rpm
	cp -lnu -t combined ftp.redhat.com/pub/redhat/linux/enterprise/6Server/en/os/SRPMS/*.src.rpm
	cp -lnu -t combined ftp.redhat.com/pub/redhat/linux/enterprise/6ComputeNode//en/os/SRPMS/*.src.rpm
	touch control/combined.empty

control/sync.empty:
	wget -c -nv -m ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6Client/en/os/SRPMS/ -a sync.log
	wget -c -nv -m ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6ComputeNode/en/os/SRPMS/ -a sync.log
	wget -c -nv -m ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6Server/en/os/SRPMS/ -a sync.log
	wget -c -nv -m ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6Workstation/en/os/SRPMS/ -a sync.log
	hardlink -cv ftp.redhat.com &>> sync.log
	touch control/last-sync.empty
