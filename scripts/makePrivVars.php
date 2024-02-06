#!/usr/bin/php
<?PHP
###############################################################################################
###> New x php -> makePrivVars.php  -> Initial creation user => eric => 2024-02-05_17:19:34 ###
###############################################################################################
#_#>
$__dir__=__dir__;
$out_ex="\n\n###> eval $(./private_vars.sh)  will set these env vars into your env.\n";
$out_va="\n\n###> Copy and uncomment this into included vars file\n";
$unset_out="#!/bin/bash\n ###> This script should unset the env vars previously exported\n";
$go=false;
$lk4='###> Private env vars';
$stop4'###> End private env vars';
$h=fopen('private_vars.sh', 'a+');

while($line=fgets($h)){
        if(trim($line)==$stop4){
                $go=false;
        }
	if(($go==true)&&(trim($line)!='')){
		$S=str_replace('#','',$line);
		$O=explode(': ',$S);
		$N=strtoupper(trim($O[0]));
		$V=trim($O[1]);
		$new_line="echo export $N='$V'\n";
		$unset_line="echo unset $N\n";
		$new_vrln="# $O[0]: ".'"{{'." lookup('env','".$N."'".')}}"'."\n";
		$out_ex.=$new_line;
		$out_va.=$new_vrln;
		$unset_out.=$unset_line;
	}
        if(trim($line)==$lk4){
                $go=true;
        }
}
echo $out_ex;
echo $out_va;
if(!fwrite($h,$out_ex)){
	die("Failed to write exports.");
}
if(!fwrite($h,$out_va)){
        die("Failed to write vars.");
}

fclose($h);
$unH=fopen('unset_vars.sh','w+');
if(!fwrite($unH, $unset_out)){
	echo ("ERROR: Failed to create the unset script!");
}else{
	exec("chmod 0700 unset_vars.sh",$out);
	print_r($out);
}
fclose($unH);
?>
