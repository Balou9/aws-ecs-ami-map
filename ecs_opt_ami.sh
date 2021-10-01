#!/bin/bash
script="ecsami"
VARIANT=$1

strparam="/aws/service/ecs/optimized-ami/$VARIANT/recommended/image_id"
aws ssm get-parameters --names "$strparam" | jq ".Parameters|.[0]|.Value"
