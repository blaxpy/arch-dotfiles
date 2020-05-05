#!/bin/bash

echo - Stopping Profile-sync-daemon
systemctl --user stop psd

echo - Removing Docker files
docker system prune

echo - Mounting backup volume
sudo mount /dev/data_vg/backup /mnt/backup/

rsync_args=()
if [[ -n "$1" ]]; then
    echo Adding --dry-run option to rsync
    rsync_args+=(--dry-run)
fi

echo
echo ~ Backup started
sudo rsync --archive --acls --xattrs --human-readable --delete --verbose --include-from=backup_include --exclude-from=backup_exclude "${rsync_args[@]}" / /mnt/backup/ \
    | grep --extended-regexp --invert-match 'var/lib/docker/|usr/src/linux-headers-' > rsync.log

echo ~ Backup finished
tail -n 2 rsync.log
echo

echo - Unmounting backup volume
sudo umount /dev/data_vg/backup

echo - Starting Profile-sync-daemon
systemctl --user start psd
