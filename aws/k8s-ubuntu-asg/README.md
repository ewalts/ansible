# Autoscaling k8s ubuntu cluster deployment by Richard Eric Walts


Self Managed Kubernetes Cluster with Ubuntu Instances Auto-scaling
---
Designed to be a low cost kuberentes cluster in AWS.
Many of the shelf solutions make things simple. But cost significantly more.

#Required Prerequisites:
 - AWS account with administrative access to EC2
 - Ansible installed and configured w/access to run plays through localhost for AWS


#Overview:
 The process begins by creating dependencies in AWS: 
  [subnet, sg, iam-role, instance-profile, ELB, DNS record].
 
 Next configures the initial Ubuntu Instance. The AMI can be from the AWS catalog.
 Currently using Ubuntu 22.04 LTS.  It runs several server setup steps, configuring a user,
 firewall settings, NTP service, updates current packages, installs Java, boto, aws-cli, etc.

 After basic configurations, it imprts the install/configure play for Kubernetes apps container runtime.

 Once all the software is installed, the AMI is created to be sued with the ASG.

 After the AMI is created, the cluster initialization play is imorted. After installing Calico Tigera operator, the join command/token is generated and stored in an s3 bucket.  

 The user-data script used with ASG fetches and runs that command joining the worker nodes to the cluster.
 
 



#Playbook tasks:

host_infrastructure.yml
- ###> Task -name: AWS - Create EC2 Instance
- ###> Task -name: Create VPC for Kubernetes
- ###> Task -name: Create subnet for kkubernetes servers
- ###> Task -name: Create security group
- ###> Task -name: Show security group sg instance_id
- ###> Task -name: Create K8s ECR Role
- ###> Task -name: AWS IAM Instance Profile - Create
- ###> Task -name: Create K8s ECR Policy
- ###> Task -name: Attach K8s IAM Role to Profile
- ###> Task -name: create classic elb for http
- ###> Task -name: New EC2 Instance
- ###> Task -name: Create a DNS record-

- ###> Task -name: Run server setup playbook

ubuntu_server_setup.yml
 - ###> Task -name: Initial server setup tasks
 - ###> Task -name: Wait for SSH
 - ###> Task -name: Update apt cache
 - ###> Task -name: Update installed packages
 - ###> Task -name: Define prefered timezone
 - ###> Task -name: Make sure NTP service exists
 - ###> Task -name: Make sure NTP service is running
 - ###> Task -name: Create the ssh _group
 - ###> Task -name: Create the ssh _group
 - ###> Task -name: Make sure we have a 'sudo' group
 - ###> Task -name: Create a user with sudo privileges
 - ###> Task -name: Add ubuntu user to the allowed group
 - ###> Task -name: Set authorized key for remote user
 - ###> Task -name: Grant SUDO access
 - ###> Task -name: Disable remote login for root
 - ###> Task -name: Change the SSH port
 - ###> Task -name: UFW - Allow ssh connections
 - ###> Task -name: UFW - Allow http/https connections
 - ###> Task -name: UFW - Allow http/https connections
 - ###> Task -name: Brute-force attempt protection for SSH
 - ###> Task -name: UFW - Deny other incoming traffic and enable UFW
 - ###> Task -name: Remove excess packages no longer needed
 - ###> Task -name: Reboot all hosts

- ###> Task -name: Run K8s installation playbook

k8s_install.yml
 - ###> Task -name: Wait for ssh
 - ###> Task -name: Create the k8s modules file.
 - ###> Task -name: Include and load k8s kernel modules.
 - ###> Task -name: modprobe
 - ###> Task -name: System configurations for Kubernetes networking
 - ###> Task -name: Add conf for containerd
 - ###> Task -name: Apply new settings
 - ###> Task -name: Install containerd
 - ###> Task -name: Turning off swap space
 - ###> Task -name: Install and configure dependencies
 - ###> Task -name: Kubernetes repository file creation
 - ###> Task -name: K8s installation Source source repository
 - ###> Task -name: Package install ation kubelet kubeadm kubectl docker.io


