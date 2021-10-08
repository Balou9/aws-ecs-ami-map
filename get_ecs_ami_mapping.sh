#!/bin/bash
OS="$1"
PROC="$2"
region=(
    ap-south-1
    ap-northeast-3
    ap-northeast-2
    ap-southeast-1
    ap-southeast-2
    ap-northeast-1
    ca-central-1
    eu-central-1
    eu-west-1
    eu-west-2
    eu-west-3
    eu-north-1
    sa-east-1
    us-east-2
    us-east-1
    us-west-1
    us-west-2
)

create_image_id_param() {
  if [[ -z "$2" ]]
  then
    image_id_param="/aws/service/ecs/optimized-ami/$1/recommended/image_id"
  else
    image_id_param="/aws/service/ecs/optimized-ami/$1/$2/recommended/image_id"
  fi
  echo $image_id_param
}

prep_payload_message() {
  if [[ -z "$2" ]]
  then
    printf "OS: $1\n---------------------\n"
    printf "Mappings:\n  AWSRegionToAMI:\n"
  else
    printf "OS: $1 Processor: $2\n-----------------------------------\n"
    printf "Mappings:\n  AWSRegionToAMI:\n"
  fi
}

get_aws_ecs_opt_ami_id() {
  if [[ -z "$2" ]]
  then
    IMAGE_ID_PARAM=$(create_image_id_param $1)
  else
    IMAGE_ID_PARAM=$(create_image_id_param $1 $2)
  fi

  for reg in ${region[@]}
  do
    image_id=$(aws ssm get-parameters \
    --names "$IMAGE_ID_PARAM" \
    --region $reg \
    | jq -r ".Parameters|.[0]|.Value"
    )
    printf "    $reg:\n      AMI: $image_id\n"
  done
}

prep_payload_message $OS $PROC && get_aws_ecs_opt_ami_id $OS $PROC
