#!/bin/bash
set -e

export AWS_ACCESS_KEY_ID=$1
export AWS_SECRET_ACCESS_KEY=$2
export DB_ROOT_PASSWORD=$3

YEAR=$(date "+%Y")
MONTH=$(date "+%m")
DATE=$(date "+%d")

function log ()
{
  msg=$1
  timestamp=$(date "+%Y-%m-%d %H:%M")
  echo "$timestamp - $msg"
}

log "[INFO] - starting vikunja backup"

# backup db
mysqldump -u root --password=$DB_ROOT_PASSWORD --protocol=tcp -h localhost vikunja > /tmp/vikunja-backup.sql

# backup files
zip -r -9 /tmp/files.zip /mnt/ssd-1/docker/volumes/vikunja_files/_data

# create one backup artifact
zip -r -9 /tmp/vikunja.zip /tmp/files.zip /tmp/vikunja-backup.sql

/usr/local/bin/aws s3 cp \
  /tmp/vikunja.zip \
  s3://vikunja-backups-bucket/$YEAR/$MONTH/$DATE/backup.zip
/usr/local/bin/aws cloudwatch put-metric-data \
  --namespace vikunja-backups \
  --metric-data MetricName=BackupCompleted,Unit=Count,Value=1,StorageResolution=60 \
  --region eu-west-1

log "[SUCCESS] - uploaded backup to S3"
