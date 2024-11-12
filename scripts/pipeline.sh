set -eou pipefail

aws cloudformation deploy \
  --template-file ci/backups-account/codepipeline.yml \
  --stack-name codepipeline-vikunja-backups \
  --capabilities CAPABILITY_IAM \
  --region eu-west-1 \
  --profile backups
