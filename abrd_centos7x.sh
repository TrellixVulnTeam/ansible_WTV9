#!/usr/bin/bash

#######################################################################################################
# Ansible Bootstrap Rapid Deployment for CentOS7x                                                     #
#                                                                                                     #
# CentOS7x Usage:                                                                                     #
#   curl https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/abrd_centos7x.sh | bash -   #
#                                                                                                     #
#                                                                ErnestGWilsonII@gmail.com 2017-12-23 #
#                                                                  https://github.com/ernestgwilsonii #
#                                                         https://www.linkedin.com/in/ernestgwilsonii #
#######################################################################################################

# Update the base OS
yum -y upgrade

# Enable EPEL Repository
yum -y install wget
wget http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-7-11.noarch.rpm -O /tmp/epel-release-7-11.noarch.rpm
yum -y localinstall /tmp/epel-release-7-11.noarch.rpm

# Install a compiler and some pre-requisites into the OS
yum -y install python-setuptools gcc libffi-devel python-devel openssl-devel krb5-devel krb5-libs krb5-workstation git sshpass tree telnet bind-utils

# Install Python pip
easy_install pip

# Install some Python module pre-requisites
pip install pybuilder
pip install mock
pip install nose
pip install coverage
pip install cryptography
pip install xmltodict
pip install "pywinrm>=0.1.1"
pip install kerberos
pip install httplib2

# Install Ansible
pip install ansible
pip install --upgrade ansible

# Set specific versions to avoid annoying warning messages
# pip uninstall chardet -y
# pip uninstall urllib3 -y
# pip uninstall chardet -y
# pip uninstall urllib3 -y
# pip install "chardet<3.1.0"
# pip install "urllib3<=1.22"

# Create default sample examples starting kit
mkdir -p /etc/ansible
mkdir -p /etc/ansible/files
mkdir -p /etc/ansible/files/Docker
mkdir -p /etc/ansible/group_vars
mkdir -p /etc/ansible/host_vars
mkdir -p /etc/ansible/templates
mkdir -p /etc/ansible/vault
echo "ChangeMeToWhateverYouWantForYourAnsibleVaultEncryptionPassword" > /etc/ansible/vault/vault_pass.txt
echo "hosts" > /etc/ansible/.gitignore
echo "vault" >> /etc/ansible/.gitignore
echo "ansible_ssh_user: \"root\"" > /etc/ansible/group_vars/CentOS7.yml
echo "ansible_ssh_pass: \"M1n1m@l!\"" >> /etc/ansible/group_vars/CentOS7.yml
echo "ansible_ssh_port: \"22\"" >> /etc/ansible/group_vars/CentOS7.yml
echo "ansible_connection: \"ssh\"" >> /etc/ansible/group_vars/CentOS7.yml
cp /etc/ansible/group_vars/CentOS7.yml /etc/ansible/group_vars/Swarm1.yml
echo "[CentOS7]" >> /etc/ansible/hosts
echo "localhost ansible_host=127.0.0.1" >> /etc/ansible/hosts
echo "" >> /etc/ansible/hosts
echo "[Swarm1]" >> /etc/ansible/hosts
echo "" >> /etc/ansible/hosts
cd /etc/ansible
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Apply-OS-Updates-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Enable-EPEL-Repository-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Install-Basic-Utilities-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Install-NTP-Services-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Install-Java8x-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Install-NodeJS-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Install-RDP-Services-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Prepare-LVM-for-Docker-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Install-Docker-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/Docker_Swarm-Join-Manager-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/Docker_Swarm-Join-Worker-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Convert-to-IPTables-playbook.yml
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/CentOS7x_Update-OS-to-Kernel4x-playbook.yml
mkdir -p /etc/ansible/files/Docker
cd /etc/ansible/files/Docker
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/files/Docker/vg_docker-lv_docker_thinpool.profile
wget https://raw.githubusercontent.com/ernestgwilsonii/ansible/master/files/Docker/etc_docker_daemon.json
cd /etc/ansible

# Create a default starting /etc/ansible/ansible.cfg
echo "[defaults]" > /etc/ansible/ansible.cfg
echo "inventory=/etc/ansible/hosts" >> /etc/ansible/ansible.cfg
echo "host_key_checking=False" >> /etc/ansible/ansible.cfg
echo "retry_files_enabled=False" >> /etc/ansible/ansible.cfg
echo "forks=100" >> /etc/ansible/ansible.cfg

# Add Ansible section to /root/.bashrc
echo " " >> /root/.bashrc
echo "# Ansible #" >> /root/.bashrc
echo "###########" >> /root/.bashrc

# Add ANSIBLE_HOST_KEY_CHECKING=False variable to .bashrc
echo "export ANSIBLE_HOST_KEY_CHECKING=False" >> /root/.bashrc

# Add ANSIBLE_VAULT_PASSWORD_FILE=/etc/ansible/vault/vault_pass.txt variable to .bashrc
echo "export ANSIBLE_VAULT_PASSWORD_FILE=/etc/ansible/vault/vault_pass.txt" >> /root/.bashrc
echo " " >> /root/.bashrc

# Display the Ansible version and next steps
clear
echo ""
echo "################################################################################"
tree /etc/ansible/
echo ""
echo "################################################################################"
echo "# Welcome to Ansible! #"
echo "#######################"
echo "ansible --version"
ansible --version
# Instruct the human:
echo ""
echo " # Next:"
echo " #######"
echo " cd /etc/ansible"
echo " ansible --version"
echo "################################################################################"
echo ""
