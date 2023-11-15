set -euo pipefail

scp -r src/usr/bin/vikunja/backup.sh apps:/tmp/backup.sh
scp -r src/usr/bin/vikunja/restore.sh apps:/tmp/restore.sh

ssh apps "sudo mv /tmp/backup.sh /usr/bin/vikunja/backup"
ssh apps "sudo mv /tmp/restore.sh /usr/bin/vikunja/restore"
ssh apps "sudo chmod +x /usr/bin/vikunja/backup"
ssh apps "sudo chmod +x /usr/bin/vikunja/restore"
