#!/bin/bash -l

set -eo pipefail

# Check configuration

err=0

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "error: AWS_ACCESS_KEY_ID is not set"
  err=1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "error: AWS_SECRET_ACCESS_KEY is not set"
  err=1
fi

if [ -z "$AWS_REGION" ]; then
  echo "error: AWS_REGION is not set"
  err=1
fi

if [ $err -eq 1 ]; then
  exit 1
fi

# Create a dedicated profile for this action to avoid
# conflicts with other actions
aws configure --profile hugo-s3 <<-EOF > /dev/null 2>&1
${AWS_ACCESS_KEY_ID}
${AWS_SECRET_ACCESS_KEY}
${AWS_REGION}
text
EOF

# Set it here to avoid logging keys/secrets
if [ "$DEBUG" = "1" ]; then
  echo "*** Enabling debug output (set -x)"
  set -x
fi

# Run "hugo deploy" as configure in your repo
hugo deploy

# Clear out credentials after we're done
# We need to re-run `aws configure` with bogus input instead of
# deleting ~/.aws in case there are other credentials living there
aws configure --profile hugo-s3 <<-EOF > /dev/null 2>&1
null
null
null
text
EOF