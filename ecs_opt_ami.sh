#!/bin/bash
script="ecsami"
VARIANT=$1

IFS='\:"|,\:' read -ra payload <<< $(aws ssm get-parameters \
  --names "/aws/service/ecs/optimized-ami/$1/recommended" \
  | jq ".Parameters|.[0]|.Value")

for (( i = 0; i < ${#payload[*]}; ++ i ))
do
  if [[ $i != "" ]] && echo ${payload[$i]} | grep -Eq "image_id|os"
  then
    echo "${payload[$i]}:" "${payload[$i+5]}"
  fi
done
