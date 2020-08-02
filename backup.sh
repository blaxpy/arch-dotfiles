#!/bin/bash

echo - Stopping Profile-sync-daemon
systemctl --user stop psd

echo - Removing Docker files
docker system prune --force

echo - Mounting backup volume
sudo mount /dev/sda1 /mnt/backup

rsync_args=()
if [[ -n "$1" ]]; then
    echo Adding --dry-run option to rsync
    rsync_args+=(--dry-run)
fi

echo
echo ~ Backup started
sudo rsync --archive --human-readable --delete --include-from=backup_include --exclude-from=backup_exclude "${rsync_args[@]}" / /mnt/backup/
echo ~ Backup finished

echo - Unmounting backup volume
sudo umount /mnt/backup

echo - Starting Profile-sync-daemon
systemctl --user start psd
