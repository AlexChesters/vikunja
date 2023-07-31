set -euo pipefail

MYSQL_ROOT_PASSWORD=$1
MYSQL_PASSWORD=$2
VIKUNJA_SERVICE_JWTSECRET=$3

sed \
  "s/{{MYSQL_ROOT_PASSWORD}}/$MYSQL_ROOT_PASSWORD/g" \
  src/usr/lib/vikunja/docker-compose.template.yml \
  > src/usr/lib/vikunja/docker-compose.tmp.yml
sed -i \
  "s/{{MYSQL_PASSWORD}}/$MYSQL_PASSWORD/g" \
  src/usr/lib/vikunja/docker-compose.tmp.yml
sed \
  "s/{{VIKUNJA_SERVICE_JWTSECRET}}/$VIKUNJA_SERVICE_JWTSECRET/g" \
  src/usr/lib/vikunja/docker-compose.tmp.yml \
  > src/usr/lib/vikunja/docker-compose.yml

scp -r src/usr/lib/vikunja/docker-compose.yml apps:/tmp/docker-compose.yml
scp -r src/usr/lib/vikunja/vikunja.conf apps:/tmp/vikunja.conf

# install vikunja
ssh apps "sudo docker compose -f /usr/lib/vikunja/docker-compose.yml stop"
ssh apps "sudo mv /tmp/docker-compose.yml /usr/lib/vikunja"
ssh apps "sudo mv /tmp/vikunja.conf /usr/lib/vikunja"
ssh apps "sudo docker compose -f /usr/lib/vikunja/docker-compose.yml up -d"
