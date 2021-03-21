#!/bin/bash
set -ex

# Add EPEL repository
# sudo apt -y install epel-release
sudo apt -y update
sudo apt -y install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
sudo apt-add-repository universe
sudo apt-get -y install python3-pip
sudo apt-get -y install openjdk-8-jdk

# Install Ansible.
sudo apt -y update
sudo apt -y install ansible

# Install boto 
sudo apt -y update
pip3 install boto3
pip3 install boto
pip3 install botocore