#!/bin/bash
script="ecsami"
VARIANT=$1

aws ssm get-parameters --names "/aws/service/ecs/optimized-ami/$1/recommended"
