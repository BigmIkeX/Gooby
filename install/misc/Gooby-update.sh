#!/bin/bash

source ${CONFIGS}/Docker/.env

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	read -t 3 -p "What Gooby branch? (just wait for default): " GOOBYBRANCH
	[[ -z ${GOOBYBRANCH} ]] && GOOBYBRANCH=v2
	echo "${GOOBYBRANCH}" > ${CONFIGVARS}/goobybranch
	echo
	echo
	echo Updating Gooby to ${GOOBYBRANCH}
	echo
	sudo rm -r /opt/.Gooby > /dev/null 2>&1
	sudo git clone -b ${GOOBYBRANCH} https://github.com/TechPerplexed/Gooby /opt/.Gooby

	if [ -d /opt/.Gooby ]; then
		sudo rm -r /opt/Gooby
		sudo mv /opt/.Gooby /opt/Gooby
		sudo chmod +x -R /opt/Gooby/install
		sudo chmod +x -R /opt/Gooby/menus
		sudo chmod +x -R /opt/Gooby/scripts/bin
		sudo chmod +x -R /opt/Gooby/scripts/cron
		sudo rsync -a /opt/Gooby/scripts/bin/* /bin
		sudo chmod 755 /bin/gooby
		sudo chmod 755 /bin/gbackup
		sudo chmod 755 /bin/plexstats
		sudo chmod 755 /bin/rclean
		sudo chmod 755 /bin/resetbackup
		sudo chmod 755 /bin/rstats
		sudo chmod 755 /bin/sizer
		sudo chmod 755 /bin/syncmount
	fi

	sleep 5

	clear

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
