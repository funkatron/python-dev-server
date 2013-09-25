#!/usr/bin/env bash

export ANSIBLE_HOSTS="${PWD}/ansible_hosts"
export ANSIBLE_HOST_KEY_CHECKING='False'

vagrant up

# ping to make sure we can talk to the machine
ansible python-dev-server -m ping -vvv

# update at sources
# ansible python-dev-server -m command -a "apt-get update" --sudo

ansible-playbook ansible_playbooks/python-dev-server.yml


echo "export ANSIBLE_HOSTS=${PWD}/ansible_hosts"
echo 'export ANSIBLE_HOST_KEY_CHECKING=False'
echo
