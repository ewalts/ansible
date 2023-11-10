---

Kubernetes Cluster in AWS on Ubuntu Instances
---
This deployment has been tested on 20.04 and 22.04, 
..... things do change.

---

You can run each play individually, but you will need to manually create any required vars/resources the scripts creates.

Very easy to deploy a Kuberentes cluster.

    $ cd $DEPLOYMENT_PATH/

    $ ./create-ubuntu-k8s-cluster.sh -vvvv

Requirements
---

1. Ansible installed and configured
2. AWS cli/access roles functioning.
3. You have created an Ubuntu AMI.
4. Define your custom vars in the  [current_play_vars.yml|~/.ansible/current_play_vars.yml] file. 


Kubernetes default restriction requires 2cpu on the instance.  The deployment currently configured to use t2.medium.


TASK [Create the kube user account] **************************************************************************************************************************************************************************************************************************
[WARNING]: 'append' is set, but no 'groups' are specified. Use 'groups' for appending new groups.This will change to an error in Ansible 2.14.

