#!/bin/bash
set -e

REGION=$1
ECR_REPO=$2
APP_PATH=$3

# Login to ECR
aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ECR_REPO

# Build and push
cd "$APP_PATH"
docker build --platform linux/amd64 -t $ECR_REPO:latest .
docker push $ECR_REPO:latest
docker rmi $ECR_REPO:latest