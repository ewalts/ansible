# ansible

Samples of my ansible deployments.  
Mostly cloud infrastructure.
Container applications, kubernetes clusters

Integrations and automations.

Some are rely almost solely on Ansilbe/Yaml,
A few have script wrappers.
# scripts
*  New version of update_inventory 
	###>  This version generates yaml intead of ini
	###>  Run it at the end of the deployment, at least after host groups/vars are populated
	###>

* Simple play to run it pass in different inventory json.  Only handles one argument currently.
      - name: Update inventory yaml file inventory/inventory.yml
        shell: |
          /usr/bin/php /path-to-scripts/update_inventory.php groups

* Leveraging newly created hosts grouped with add_host:

      - name: Register MysQL host to groups ec2hosts and mysql
        add_host:
          hostname: "{{ ec2_db['instances'][0]['network_interfaces'][0]['association']['public_ip'] }}"
          groups:
            - ec2hosts
            - mysql
        register: groups
