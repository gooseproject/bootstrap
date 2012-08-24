#!/bin/sh
# This script performs a binary backup of the koji database
# To restore the backup file run pg_restore -C -d koji koji$DATEDFILE$.dump
# Place this in /etc/cron.weekly for weekly backups
# TODO Automatic backup's to something like Amazon's Glacier
pg_dump -U postgres -Fc koji > /home/koji/kojidb`date +%Y%m%d`.dump
mv /home/koji/kojidb`date +%Y%m%d`.dump /mnt/koji/pg_backup/
find /mnt/koji/pg_backup/koji* -mtime +14 -exec rm {} \; 
