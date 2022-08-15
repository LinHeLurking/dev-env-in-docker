#!/bin/bash

_username=""
_password=""
_tag=""

while [ "$#" -gt 0 ]; do
    case $1 in 
        --username) _username=$2; shift ;;
        --password) _password=$2; shift ;;
        --tag) _tag=$2; shift ;;
    esac
    shift
done

print_usage() {
    echo "Build a docker development image."
    echo "bash ./build.sh --username <xxx> --password <xxx> --tag <xxx>"
    echo "Example: bash ./build.sh --username dev --password dev --tag dev-img"
    echo ""
    echo "    --username  The username used in built docker image."
    echo "    --password  Similar as above."
    echo "    --tag       Docker image tag."
}

[ "$_username" = "" ] && echo "Must provide a username!" && print_usage && exit 1
[ "$_password" = "" ] && echo "Must provide a password!" && print_usage && exit 1
[ "$_tag" = "" ] && echo "Must provide a tag!" && print_usage && exit 1

set -o xtrace

cat Dockerfile | sed s/username=/username=$_username/g | sed s/password=/password=$_password/g | docker build -t $_tag . -f -
