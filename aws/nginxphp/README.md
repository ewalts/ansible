#Nginx / PHP-FPM

Multi-technology deployment of Nginx with PHP-FPM
---
I intentionally leveraged multiple technologies to create this Docker deployment.  My intention, to demonstrate that each are capable of performing the job, and also integrate well to leverage individual strengths.
- Requires basic php installation.

#Very easy to deploy.

Run or execute the commands in this script to pull the deployment.


    #!/bin/bash

    mkdir my_project
    cd my_project

    git init
    git remote add -f origin https://github.com/ewalts/ansible.git
    git config core.sparseCheckout true
    echo "aws/nginxphp/" >> .git/info/sparse-checkout
    git pull origin main


    
You will need to modify two of the vars files in aws/nginxphp/vars
---
The aws/nginxphp/vars/new-ubuntu-instance_vars.yml has these variables
---

    new_env: nginx_php
    item: nginx-php-1
    key_name: my_key_pair_name
    ins_type: t2.micro
    subnet: my_subnet
    ami_id: my_ami_id
    sg: my_security_group_name
    key_file: /local/path/to/my/key.pem
    my_ssh_key_path: /local/path/to/my/key.pem
    iam_role: nginx_role
    instance_profile: instance_profile
    iam_name: nginx_iam_name
    policy_name: nginx_policy


The aws/nginxphp/vars/server_setup_vars.yml 
---
    ssh_group: my_remote_admin_group
    my_timezone: 'Pacific/Honolulu'
    my_user: my_remote_user
    copy_local_key: "{{ lookup('file', lookup('env','HOME') + '/.ssh/id_rsa.pub') }}"



You shouldn't need to modify settings in aws/nginxphp/vars/compose_vars.yml
---

    src_dir: ./docker-files
    nginx_dir: /var/docker/web/nginx
    php_dir: /var/docker/web/php
    www_dir: /var/docker/www/html
    mysql_dir: /var/docker/mysql
   
Once you change to the nginxphp directory just execute the script to run the deployment.  The -v args are passed to each playbook that is executed.
---
     
    cd aws/nginxphp

    ./create-nginx-php-app.sh -vv


