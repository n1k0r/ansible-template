#!/usr/bin/env bash

# Use this script for initial configuration of new host
# It creates administrator user which used by other playbooks

if (($# < 1 || $# > 3)); then
    echo "Usage:    ./initial.sh <host> [group | '-'] ['publickey' (default) | 'password']"
    echo "Examples: ./initial.sh user@host"
    echo "          ./initial.sh user@host group"
    echo "          ./initial.sh user@host group password"
    exit 1
fi

HOST=$1
GROUP=$2
AUTH=$3

if [[ ! -z "$AUTH" ]] && [[ "$AUTH" != "password" ]] && [[ "$AUTH" != "publickey" ]]; then
    echo "Wrong auth argument"
    exit 1
fi

params=(-i $HOST,)
params+=(-e "ansible_python_interpreter=/usr/bin/python3")

[[ ! -z "$GROUP" ]] && [[ "$GROUP" != "-" ]] && \
    params+=(-e @inventory/group_vars/$GROUP/base.yml)

[[ ! -z "$AUTH" ]] && [[ "$AUTH" == "password" ]] && \
    params+=(--ssh-common-args "-o PreferredAuthentications=password -o PubkeyAuthentication=no" -k -K)

cd "$(dirname "$0")"
ansible-playbook initial.yml "${params[@]}"

if [ $? -ne 0 ]; then
    exit
fi

echo "Don't forget to add new host to inventory"
