#!/bin/bash
script="ecsami"
VARIANT=$1

IFS='\:"|,\:' read -ra payload <<< $(aws ssm get-parameters \
  --names "/aws/service/ecs/optimized-ami/$1/recommended" \
  | jq ".Parameters|.[0]|.Value")

# get_image_id(param) {
#
# }
#
# get_os(param) {
#
# }

for i in "${payload[@]}"
do
  if [[ $i != "" ]]
  then
    echo $i
  fi
done

aws ssm get-parameters \
  --names "/aws/service/ecs/optimized-ami/$1/recommended"
