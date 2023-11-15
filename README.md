# vikunja
my vikunja instance

# backup and restoring
These scripts are deployed by [`scripts/deploy.sh`](./scripts/deploy.sh)

## backups
Backups are performed by [`a script`](./src/usr/bin/vikunja/backup.sh) which exists on the raspberry pi as
`/usr/bin/vikunja/backup`. This script is executed daily by cron.

## restoring
Restoring a backup can be performed by [`a script`](./src/usr/bin/vikunja/restore.sh) which exists on the raspberry
pi as `/usr/bin/vikunja/restore`. To use this script you must first retrieve a backup from S3 and place the SQL dump
file somewhere on the raspberry pi.
