---

Build Kubernetes Cluster in AWS on Ubuntu Instances
---

This assumes you already have an Ubuntu ami that meets your compliance standards.
---


Define you custom vars in the  current_play_vars.yml file.

First run this play to create the hosts.
    ansible-playbook -i aws-hosts current_play.yml

Pull the public IP addresses  with your ssh access key file path.

    aws ec2 describe-network-interfaces | grep '     PublicIp' |awk '{print $2}'

Edit the aws-hosts file adding the public IP address along with your ssh access key file path.


Then run this play.

    ansible-playbook -u ubuntu -i aws-hosts k8s_install.yml 

