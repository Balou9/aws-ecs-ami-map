#!/bin/bash
script="ecs-ami"

function example {
    echo -e "example: $script -var amazon-linux-2 -ver recommended -it VAL"
}

function usage {
    echo -e "usage: $script --variant [--version] [--instanceType]"
}

function help {
  usage
    echo -e "MANDATORY:"
    echo -e "  -var, --variant  VAL  Amazon ECS-optimized AMI variant"
    echo -e "OPTION:"
    echo -e "  -ver, --version  VAL  Amazon ECS-optimized AMI version\n"
    echo -e "  -it, --instanceType  VAL  Amazon EC2 instance type \n"
    echo -e "  -h,  --help             Prints this help\n"
  example
}


VARIANT=
VERSION="recommended"
INSTANCE_TYPE=
