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
c=0

k8scp="\n[k8scp]\n"
k8swn="[k8swn]\n"

for h in $hosts;
do
        c=$((c+1))
        echo "$h  ansible_ssh_private_key_file=$my_ssh_key_path" >> aws-hosts
        if [ $c = 1 ] 
	then
                k8scp=${k8scp}"$h  ansible_ssh_private_key_file=$my_ssh_key_path\n"
        elif [ $c > 1 ]
	then
                k8swn=${k8swn}"$h  ansible_ssh_private_key_file=$my_ssh_key_path \n"
        fi
done
echo -e $k8scp >> aws-hosts
echo -e $k8swn >> aws-hosts

