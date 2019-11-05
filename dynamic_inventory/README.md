Projeto para inventário dinamico usando ansible na AWS

- Baixar o script.sh
- Dar permissao de execução chmod +x script.sh
- Alterar os campos do script:
    [[HOSTS]:children] = ex: [webservers:children]
    
    tag_Name_[TAG_AWS] = ex: tag_Name_webservers
    
    [[HOSTS]:vars] = ex: [webservers:vars]
    
    ansible_user=[USER] = ex: ansible_user=administrator
    
    ansible_password=[PASSWORD] = ex: ansible_password=123456789
    
    aws configure set aws_access_key_id [ACCESS_KEY] = ex: ... aws_access_key_id AKIAXXXXXXXXXXXXXX 
    
    aws configure set aws_secret_access_key  [SECRET_KEY] = ex: ... aws_secret_access_key XYZWSDDECECWEC
    
- Executar o script = ./script.sh

OBS* Script utilizado para inventario com EC2 Windows, todas as EC2 devem estar com winrm habilitadas,
com security group e firewall windows com permissão nas portas 5985 e 5986.


