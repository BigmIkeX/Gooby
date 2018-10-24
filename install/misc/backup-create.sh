#!/bin/bash

clear

EXPLAINTASK

CONFIRMATION

if [[ ${REPLY} =~ ^[Yy]$ ]]; then

	GOAHEAD

	BACKUP=/tmp/$(date +%F).tar.gz

	echo -e "The backup can take several hours"
	echo -e "Please don't exit the terminal until it's done!"
	echo ""

	echo -e "${LMAGENTA}Creating backup file...${STD}"

	sudo tar -cf ${BACKUP} $CONFIGS --exclude-caches-all

	sudo chown $USER:$USER ${BACKUP}

	echo -e "${GREEN}Copying to Google...${STD}"

	/usr/bin/rclone copy ${BACKUP} Gdrive:/Backup/$(hostname) --checksum --drive-chunk-size=64M
	sudo rm ${BACKUP}

	sudo chown $USER:$USER ${CONFIGS}
	sudo chown $USER:$USER ${HOME}

	clear
	echo "${YELLOW}"
	echo "--------------------------------------------------"
	echo " Done! The backup can be found"
	echo " In your Google Backup folder"
	echo "--------------------------------------------------"
	echo "${STD}"

	if [ ! -f $TCONFIGS/cronbackup ]; then

		echo ""
		read -n 1 -s -r -p " Would you like to schedule a weekly backup (y/N)? "
		echo ""

		if [[ ${REPLY} =~ ^[Yy]$ ]]; then

			(crontab -l 2>/dev/null; echo "15 2 * * SUN /opt/Gooby/scripts/cron/backup.sh > /dev/null 2>&1") | crontab -
			touch $TCONFIGS/cronbackup
			echo " Backup scheduled to run at 02:15 every Sunday"
			echo " You can always change this by typing ${LYELLOW}crontab -e${STD}"

		else

			echo "No worries, you can always add a backup schedule later!"

		fi

	fi

	TASKCOMPLETE

else

	CANCELTHIS

fi

PAUSE
