#!/bin/bash
###############################################################################################
###> New x bash -> private_vars.sh  -> Initial creation user => ewalts => 2024-02-05_17:17:05 ###
###############################################################################################
#_#>  
#    This script relys on another script in the same dir.
#    The php script makePrivVars.php will read the commented vars below and generate two more blocks below. 
#    Define the your below, DO NOT uncomment them!
#    the line that above that says //Private vars blah blah, is required. The other script does not process anything before that line.
#    Only the echo export VAR='value'  should be uncommented, interpreter as well. haha
#     
###>  You must eval the scirpt to set the vars
#
##>    >>>  my_prmpt]$ eval $(./private_vars.sh)
#
###> Private env vars
# my_user: mcdude
# my_group: mcgroup
# my_ip: 223.223.223.223/32
# key_name: mccrt
# deployment_log: ~/dep-1/apache-site/output/deployment_register_vars.yml
# key_file: ~/.securepath/project/mccrt.pem
# my_ssh_key_path: ~/.securepath/project/mccrt.pem
# dns_zone: mcdomain.info
# web_host_fqdn: wp1.mcdomain.info
# db_host_fqdn: wp-db1.mcdomain.info 
# db_file: rwi_wp.sql
###> End private env vars


