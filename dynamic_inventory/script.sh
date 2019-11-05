#!/bin/bash
############################################################################
#######        Inventario dinamico AWS com Ansible e Windows         #######
############################################################################
# ANSIBLE INVENTARIO DINAMICO Windows ######################################
############################################################################
#Instalar os pacotes necessarios
sudo apt-get update && sudo apt-get install software-properties-common -y
sudo apt-add-repository universe -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update && sudo apt-get install ansible python-pip -y
sudo pip install boto
sudo pip install boto3
sudo pip install "pywinrm>=0.3.0" 
sudo pip install cryptography

#Criar os diretorios do inventario 
mkdir /etc/ansible/inventory/
mkdir /etc/ansible/inventory/prod

#Baixar os arquivos ec2.py e ec2.ini, dar permissao de execucao, criar hosts,e instalar vim
wget -c -P /etc/ansible/inventory/prod/ https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.py 
wget -c -P /etc/ansible/inventory/prod/ https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini 
chmod +x /etc/ansible/inventory/prod/ec2.py
touch /etc/ansible/inventory/prod/hosts
apt install wget vim -y

#Popular o arquivo de hosts com as tags da AWS e metodo, usuario e senha de login no windows
cat >'/etc/ansible/inventory/prod/hosts' <<EOT
[[HOSTS]:children]
tag_Name_[TAG_AWS]
tag_Name_[TAG_AWS]
tag_Name_[TAG_AWS]

[[HOSTS]:vars]
ansible_user=[USER]
ansible_password=[PASSWORD]
ansible_connection=winrm
ansible_winrm_server_cert_validation=ignore
ansible_port=5985
EOT

#Criar o arquivo para teste ping.yaml 
cat >'/etc/ansible/ping.yaml' <<EOF
---
- name: Ping
  hosts: webservers

  tasks:
  - name: ping
    win_ping:
EOF

#Instalar e configurar o AWSCLI
sudo apt install awscli -y
aws configure set aws_access_key_id [ACCESS_KEY]
aws configure set aws_secret_access_key  [SECRET_KEY]	
aws configure set default.region us-east-1
aws configure set default.output json

#Teste a conexao com os hosts 
ansible-playbook -i /etc/ansible/inventory/prod/ /etc/ansible/ping.yaml -vvv
