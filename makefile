all:
	@echo all

control/requires.empty: control/specs.empty
	for i in combined/*src.rpm
	do 
	  rpm -qRp ${i} > requires/${i}.requires
	done  
	touch control/requires.empty

control/specs.empty: combined/*.src.rpm
	for i in combined/*.src.rpm
	do
	  mkdir specs/${i}
	  cd specs/${i}
	  rpm2cpio ../../${i} | cpio -iumd \*.spec
	  cd ../..
	done
	touch control/specs.empty

control/combined.empty: control/sync.empty
	cp -lnu -t combined ftp.redhat.com/pub/redhat/linux/enterprise/6Client/en/os/SRPMS/*.src.rpm &>> logs/combined.log
	cp -lnu -t combined ftp.redhat.com/pub/redhat/linux/enterprise/6Workstation/en/os/SRPMS/*.src.rpm &>> logs/combined.log
	cp -lnu -t combined ftp.redhat.com/pub/redhat/linux/enterprise/6Server/en/os/SRPMS/*.src.rpm &>> logs/combined.log
	cp -lnu -t combined ftp.redhat.com/pub/redhat/linux/enterprise/6ComputeNode//en/os/SRPMS/*.src.rpm &>> logs/combined.log
	touch control/combined.empty &>> logs/combined.log

control/sync.empty:
	wget -c -nv -m ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6Client/en/os/SRPMS/ -a logs/sync.log
	wget -c -nv -m ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6ComputeNode/en/os/SRPMS/ -a logs/sync.log
	wget -c -nv -m ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6Server/en/os/SRPMS/ -a logs/sync.log
	wget -c -nv -m ftp://ftp.redhat.com/pub/redhat/linux/enterprise/6Workstation/en/os/SRPMS/ -a logs/sync.log
	hardlink -cv ftp.redhat.com &>> logs/sync.log
	touch control/sync.empty
