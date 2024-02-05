#!/usr/bin/php
<?PHP
###########################################################################################################
###>  This script reads a json dump file from ansible package facts.
###>  It turns the json into an array and generates two yaml files
###>  One is playbook that would install every package installed on the host it was gathered from.
###>  This script does not include any filters which could be introduced in a couple different ways.
##[eric - 2024-02-05-02:58:44]#>  Installed packages documentation/management script
#####################################################################
#_#>
#
###> CLI colors
# $Red='\e[0;31m'; $BRed='\e[1;31m'; $BIRed='\e[1;91m'; $Gre='\e[0;32m'; $BGre='\e[1;32m'; $BBlu='\e[1;34m'; $BWhi='\e[1;37m'; $RCol='\e[0m';

$__dir__=__dir__;

###> json file from play
$h=fopen('/tmp/package_dump.json','r');

$json='';
while ($lines=fgets($h)){
	$json.=$lines;
}
fclose($h);

$dump= json_decode($json, true);  ###> turn the json into array
$t=$dump['ansible_facts']['packages'];
$tasks=array();
$tc=0;
foreach($t as $key => $value){
	$pkgs[]=$value[0];
//echo $key."\n";
	###> Build install task -- later
	$tasks[$tc]['name']='Package exists '.$key;
	$tasks[$tc]['ansible.builtin.package']= array("name" => $key, "state" => "present");
	$tc++;
}
$play[0]= array (
'name' => 'Package build Ubu_22.04_1.1',
'hosts' => 'ubu_2204',
'become' => 'true',
'tasks' => $tasks);

###> Serialize and store in CMDB -- future
//$pkgs_store=serialize($pkgs);


$dump=array_filter($dump);  // Attempt strip the empty elements

###> Turn array into yaml
$yml=yaml_emit($dump, YAML_UTF8_ENCODING, YAML_ANY_BREAK);
$playbook=yaml_emit($play, YAML_UTF8_ENCODING, YAML_ANY_BREAK);

//$d=date('Y-m-d');
//echo $playbook;

###> create output yaml
$yHandle = fopen($__dir__.'/output.yml','w');
###> 
$playHandle=fopen($__dir__.'/package_playbook.yml','w');
if(!fwrite($playHandle,$playbook)){
        echo "FAILURE: Error to write the new playbook file.";
} 

if(!fwrite($yHandle,$yml)){
	echo "FAILURE: Error to write the yaml package list.";
}
fclose($yHandle);
fclose($playHandle);

?>
