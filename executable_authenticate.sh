#! /bin/sh

touch ~/.netrc 
chmod u+rw ~/.netrc 
sed -i -e '/machine doctrine-shared-514693230239.d.codeartifact.eu-central-1.amazonaws.com/,+2d' ~/.netrc 
echo -e "machine doctrine-shared-514693230239.d.codeartifact.eu-central-1.amazonaws.com\n  login aws\n  password $(aws codeartifact get-authorization-token --domain doctrine-shared --domain-owner 514693230239 --region eu-central-1 --output text --query authorizationToken)" >> ~/.netrc

# Docker ECR login to Doctrine-Shared
aws ecr get-login-password --region=eu-central-1 | docker login \
    --username AWS \
    --password-stdin 514693230239.dkr.ecr.eu-central-1.amazonaws.com

# Docker ECR login to aws-legacy-production
# FND-5081: This is due to the local-db/webonly-empty still pushed to ECR aws-legacy-production
# Search for FND-5081 for additional references
/usr/local/bin/aws ecr get-login-password --region=eu-central-1 | docker login \
    --username AWS \
    --password-stdin 969128231552.dkr.ecr.eu-central-1.amazonaws.com
