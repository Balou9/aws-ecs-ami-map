#!/bin/bash
script="ecs-ami"
mandatory_args=1
example () {
    echo -e "example: $script -var amazon-linux-2"
}

usage () {
    echo -e "usage: $script --variant [--version] [--instanceType]"
}

help () {
  usage
    echo -e "MANDATORY:"
    echo -e "  -var, --variant        Amazon ECS-optimized AMI variant"
    echo -e "OPTION:"
    echo -e "  -ver, --version        Amazon ECS-optimized AMI version\n"
    echo -e "  -it,  --instanceType   Amazon EC2 instance type \n"
    echo -e "  -h,   --help           Prints this help\n"
  example
}


VARIANT=
VERSION="recommended"
INSTANCE_TYPE=
