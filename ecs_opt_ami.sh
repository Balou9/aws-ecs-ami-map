#!/bin/bash
VARIANT="$1"
PROC="$2"

create_image_id_string_param() {
  if [[ -z "$2" ]]
  then
    image_id_param="/aws/service/ecs/optimized-ami/$VARIANT/recommended/image_id"
  else
    image_id_param="/aws/service/ecs/optimized-ami/$VARIANT/$PROC/recommended/image_id"
  fi

  echo $image_id_param
}

create_string_param_os () {
  if [[ -z "$2" ]]
  then
    os_param="/aws/service/ecs/optimized-ami/$VARIANT/recommended/os"
  else
    os_param="/aws/service/ecs/optimized-ami/$VARIANT/$PROC/recommended/os"
  fi

  echo $os_param
}

IMAGE_ID_PARAM=$(create_image_id_string_param $VARIANT)
OS_PARAM=$(create_string_param_os $VARIANT)

aws ssm get-parameters --names "$OS_PARAM" | jq ".Parameters|.[0]|.Value"
aws ssm get-parameters --names "$IMAGE_ID_PARAM" | jq ".Parameters|.[0]|.Value"
