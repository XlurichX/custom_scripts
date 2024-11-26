#!/bin/bash
# dirs
backup_dir="/apple/var/log/backups"
source_dir="/apple/var/log"
date=$(date +"%Y_%m_%d")
backup_file="${backup_dir}/backup_${date}.tar.gz"

# backup server

remote_user="backup"
remote_host="1.2.3.4"
remote_back_dir="/home/backup/"

# backup create

echo "Starting..."
mkdir -p $backup_dir
tar -czf $backup_file $source_dir
echo "Backup successful: $backup_file"

# Send to backup server

echo "Sending..."
rsync -avrPphzz  $backup_file ${remote_user}@${remote_host}:${remote_back_dir}
if [ $? -eq 0 ]; then
    echo "Backup successfull transfered"
else
    echo "Error: Failed transfer"
fi


