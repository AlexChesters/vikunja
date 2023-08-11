set -euo pipefail

scp -r src/usr/bin/vikunja/backup.sh apps:/tmp/backup.sh

ssh apps "sudo mv /tmp/backup.sh /usr/bin/vikunja/backup"
ssh apps "sudo chmod +x /usr/bin/vikunja/backup"
