#!/bin/bash
############################################################################################################
###> New x bash -> create-ubuntu-k8s-cluster.sh  -> Initial creation user => eric => 2023-11-06_22:27:21 ###
############################################################################################################
#_#>
# CLI Colors
Red='\e[0;31m'
BRed='\e[1;31m'
BIRed='\e[1;91m'
Gre='\e[0;32m'
BGre='\e[1;32m'
BBlu='\e[1;34m'
BWhi='\e[1;37m'
RCol='\e[0m'




rm -f aws-hosts

echo '[local]
localhost

' >> aws-hosts

ansible-playbook -i aws-hosts current_play.yml


my_ssh_key_path=$(cat current_play_vars.yml |grep my_ssh_key_path | awk '{print $2}')

echo "
[k8s]" >> aws-hosts
hosts=$(aws ec2 describe-instances --filters Name=tag:environment,Values=k8s|grep PublicIpAddress |awk '{print $2}')
for h in $hosts;
do
	echo "$h  ansible_ssh_private_key_file=$my_ssh_key_path" >> aws-hosts
done

wait 45
echo " Waiting 45 seconds for instances to start."


ansible-playbook -u ubuntu -i aws-hosts k8s_install.yml

