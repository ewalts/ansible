#!/bin/bash
############################################################################################################
###> New x bash -> create-ubuntu-k8s-cluster.sh  -> Initial creation user => eric => 2023-11-06_22:27:21 ###
############################################################################################################
#_#>

rm -f aws-hosts
rm /tmp/k8s_hosts
echo '[local]
localhost

' >> aws-hosts

ansible-playbook -i aws-hosts current_play.yml $1


my_ssh_key_path=$(cat current_play_vars.yml |grep my_ssh_key_path | awk '{print $2}')

echo "
[k8s]" >> aws-hosts
hosts=$(aws ec2 describe-instances --filters Name=tag:environment,Values=k8s|grep PublicIpAddress |awk '{print $2}')
priv_hosts=$(aws ec2 describe-instances --filters Name=tag:environment,Values=k8s|grep PrivateIpAddress |awk '{print $2}' \
 | sed -n '/^$/d;G;/^\(.*\n\).*\n\1$/d;H;P;a\ ')

###> Create the aws-hosts file for ansible local with public Ip addresses
c=0
k8scp="\n[k8scp]\n"
k8swn="[k8swn]\n"
for h in $hosts;
do
        echo "$h  ansible_ssh_private_key_file=$my_ssh_key_path" >> aws-hosts
        if [ $c = 0 ]
        then
		echo "$h    k8s-cp" >> /tmp/pub_hosts
                k8scp=${k8scp}"$h  ansible_ssh_private_key_file=$my_ssh_key_path\n"
        elif [ $c > 0 ]
        then
		echo "$h    k8s-wn$c" >> /tmp/pub_hosts
                k8swn=${k8swn}"$h  ansible_ssh_private_key_file=$my_ssh_key_path \n"
        fi
	c=$((c+1))
done
echo -e $k8scp >> aws-hosts
echo -e $k8swn >> aws-hosts

###> Create the hosts file with private ips
c=0
for ph in $priv_hosts;
do
        if [ $c = 0 ]
        then
                echo "$ph    k8s-cp k8s-cp.rewbin.org" >> /tmp/k8s_hosts
        elif [ $c > 0 ]
        then
                echo "$ph    k8s-wn$c k8s-wn$c.rewbin.org" >> /tmp/k8s_hosts
        fi
        c=$((c+1))
done

wait 45
echo " Waiting for SSH on new instances."

ansible-playbook -u ubuntu -i aws-hosts kube_user.yml $1

ansible-playbook -u ubuntu -i aws-hosts k8s_install.yml $1

ansible-playbook -u ubuntu -i aws-hosts cluster_init.yml $1

ansible-playbook -u ubuntu -i aws-hosts join_k8s_workers.yml $1

