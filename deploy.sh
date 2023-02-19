#!/bin/bash -e
PROJECT_NAME=meetout-ecs-go
GITHUB_REPO=meetoutECS
GITHUB_OWNER=gauravatmeetout
GITHUB_OAUTH_TOKEN=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

CICD_STACK_NAME=$PROJECT_NAME"-deploy"
MAIN_STACK_NAME=$PROJECT_NAME"-main"

echo "CICD_STACK_NAME--->"$CICD_STACK_NAME
echo "MAIN_STACK_NAME--->"$MAIN_STACK_NAME


aws cloudformation create-stack --stack-name $CICD_STACK_NAME --template-body file://template.yml --parameters ParameterKey=GitHubOwner,ParameterValue=$GITHUB_OWNER ParameterKey=GitHubOAuthToken,ParameterValue=$GITHUB_OAUTH_TOKEN ParameterKey=GitHubRepo,ParameterValue=$GITHUB_REPO ParameterKey=StackName,ParameterValue=$MAIN_STACK_NAME --capabilities CAPABILITY_IAM

echo "Creating the CloudFormation stack, this will take a few minutes ..."

aws cloudformation wait stack-create-complete --stack-name $CICD_STACK_NAME

echo "Done! Send an HTTP request to the following URL, please."
aws cloudformation describe-stacks --stack-name $CICD_STACK_NAME 