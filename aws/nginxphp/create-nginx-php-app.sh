#!/bin/bash
############################################################################################################
###> New x bash -> create-project.sh  -> Initial creation user => eric => 2023-08-06_12:27:21 ###
############################################################################################################
#_#>

###> Good for one user. This script was created with instance deployment in mind. For mutilple users I suggest random generate/log.
my_user=$(cat vars/new-ubuntu-instance_vars.yml |grep user | awk '{print $2}')

echo "Enter the password for new user [$my_user]:"
while IFS= read -r -s -n1 pass; do
  if [[ -z $pass ]]; then
     echo 
     break
  else
     echo -n '*'
     password+=$pass
  fi
done

export MY_PASS=$(./scripts/crypt_this.py $password)


rm -f inventory/nginx-hosts
rm -f /tmp/nginx_hosts
rm -f /tmp/pub_nginx_hosts
echo '[local]
localhost

' >> inventory/nginx-hosts

ansible-playbook -i inventory/nginx-hosts playbook/new-ubuntu-instance.yml $1


my_ssh_key_path=$(cat vars/new-ubuntu-instance_vars.yml |grep my_ssh_key_path | awk '{print $2}')

echo "
[nginx_php]" >> inventory/nginx-hosts
hosts=$(aws ec2 describe-instances --filters Name=tag:environment,Values=nginx_php|grep PublicIpAddress |awk '{print $2}')
priv_hosts=$(aws ec2 describe-instances --filters Name=tag:environment,Values=nginx_php|grep PrivateIpAddress |awk '{print $2}' \
 | sed -n '/^$/d;G;/^\(.*\n\).*\n\1$/d;H;P;a\ ')

c=0;
###> Create the nginx-hosts file for ansible local with public Ip addresses
for h in $hosts;
do
	echo "$h  ansible_ssh_private_key_file=$my_ssh_key_path" >> inventory/nginx-hosts
	echo "$h    nginx-php-$c" >> /tmp/pub_nginx_hosts
	c=$(($c+1))
done
c=0;
###> Create the hosts file with private IPs
for ph in $priv_hosts;
do
	echo "$ph    nginx-php-$c nginx$c.rewbin.org" >> /tmp/nginx_hosts
	c=$(($c+1))
done

echo "   ...... Waiting for 30 seconds for SSH on new instances."
wait 30 
ansible-playbook -u ubuntu -i inventory/nginx-hosts playbook/server_setup.yaml $1  ###> basic ubuntu setup 
ansible-playbook -u ubuntu -i inventory/nginx-hosts playbook/compose.yml $1  ###> compose and run nginx

export MY_PASS=10101010101010101010101010
