#!/bin/bash

REGION=ap-northeast-1
ACCOUNT_ID=381492111475
ACCESS_KEY=AKIAVRUVTVBZ7QY33A55
SECRET_KEY=JvP/WB7NSJJP0m/FaFUtQOTrR/y45AXz98Q3BPnA
COMMIT_HASH=default
ECS_CLUSTER_NAME=example
ECS_SERVICE_NAME=examplegw

# Define an array of task definitions
TASK_DEFINITIONS=("examplegw:1" "example2:1" "example1:1")

# Iterate through task definitions and update ECS service
for TASK_DEF in "${TASK_DEFINITIONS[@]}"; do
  # Update ECS service
  aws ecs update-service \
    --region $REGION \
    --cluster $ECS_CLUSTER_NAME \
    --service $ECS_SERVICE_NAME \
    --task-definition $TASK_DEF

  # Tag ECS tasks with the commit hash
  aws ecs tag-resource \
    --region $REGION \
    --resource-arn arn:aws:ecs:$REGION:$ACCOUNT_ID:service/$ECS_SERVICE_NAME \
    --tags key=CommitHash,value=$COMMIT_HASH
done

