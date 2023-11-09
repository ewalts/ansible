#!/bin/bash
############################################################################################################
###> New x bash -> create-ubuntu-k8s-cluster.sh  -> Initial creation user => eric => 2023-11-06_22:27:21 ###
############################################################################################################
#_#>

rm -f aws-hosts

echo '[local]
localhost

' >> aws-hosts

ansible-playbook -i aws-hosts current_play.yml $1


my_ssh_key_path=$(cat current_play_vars.yml |grep my_ssh_key_path | awk '{print $2}')

echo "
[k8s]" >> aws-hosts
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


wait 45
echo " Waiting for SSH on new instances."

ansible-playbook -u ubuntu -i aws-hosts kube_user.yml $1

ansible-playbook -u ubuntu -i aws-hosts k8s_install.yml $1

ansible-playbook -u ubuntu -i aws-hosts cluster_init.yml $1

ansible-playbook -u ubuntu -i aws-hosts join_k8s_workers.yml $1

