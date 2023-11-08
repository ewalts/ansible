#!/bin/bash
################################################################################################
###> New x bash -> gen-aws-hosts.sh  -> Initial creation user => eric => 2023-11-06_20:07:44 ###
################################################################################################
#_#>
# CLI Colors

rm -f aws-hosts

echo '[local]
localhost

' >> aws-hosts

my_ssh_key_path=$(cat current_play_vars.yml |grep my_ssh_key_path | awk '{print $2}')

echo "[k8s]" >> aws-hosts
hosts=$(aws ec2 describe-instances --filters Name=tag:environment,Values=k8s|grep PublicIpAddress |awk '{print $2}')
for h in $hosts;
do
	echo "$h  ansible_ssh_private_key_file=$my_ssh_key_path" >> aws-hosts
done
