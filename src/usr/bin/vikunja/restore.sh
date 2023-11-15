set -e

export DB_ROOT_PASSWORD=$1
export DB_BACKUP_PATH=$2

mysql -u root --password=$DB_ROOT_PASSWORD --protocol=tcp -h localhost vikunja < $DB_BACKUP_PATH

echo "successfully restored mysql backup, now restart DB and API (in that order)"
