#!/bin/bash
set -e

export AWS_ACCESS_KEY_ID=$1
export AWS_SECRET_ACCESS_KEY=$2

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

# TODO: backup
