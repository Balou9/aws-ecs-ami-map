#!/bin/bash
VARIANT="$1"
PROC="$2"
regions=(
    us-east-2
    us-east-1
    us-west-1
    us-west-2
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
)

create_image_id_string_param() {
  if [[ -z "$2" ]]
  then
    image_id_param="/aws/service/ecs/optimized-ami/$VARIANT/recommended/image_id"
  else
    image_id_param="/aws/service/ecs/optimized-ami/$VARIANT/$PROC/recommended/image_id"
  fi

  echo $image_id_param
}

get_aws_region_to_ami_mapping() {
  IMAGE_ID_PARAM=$(create_image_id_string_param $VARIANT)

  printf "Mappings:\n  AWSRegionToAMI:\n"
  for region in ${regions[@]};
  do
    image_id=$(aws ssm get-parameters --names "$IMAGE_ID_PARAM" --region $region | jq -r ".Parameters|.[0]|.Value")
    printf "    $region:\n      AMI: $image_id\n"
  done
}

get_aws_region_to_ami_mapping
