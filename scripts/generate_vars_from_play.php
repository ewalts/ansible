#!/usr/bin/php
<?PHP
##########################################################################################################
###> New x php -> generate_vars_from_play.php  -> Initial creation user => eric => 2023-10-25_11:11:31 ###
##########################################################################################################
###>	Usage  $./generate_vars_from_play.php ${playbook-file}
###>    New file will be created from the first -name: in the yaml file
#############################################################################
#_#>

###> CLI colors
# $Red='\e[0;31m'; $BRed='\e[1;31m'; $BIRed='\e[1;91m'; $Gre='\e[0;32m'; $BGre='\e[1;32m'; $BBlu='\e[1;34m'; $BWhi='\e[1;37m'; $RCol='\e[0m';
$v=false;
$name=false;
$vars[]="###>  Vars generated from generate_vars_from_play.php from rewbin.org Richard Walts, Inc.";
try {
    if($argv[1]==''){
	throw new exception($e);
	$message="Valid file was not provided";
    }else{
	if(!is_file($argv[1])){
		throw new exception($e);
    		$message="Valid file was not provided";
	}
    }
}
catch(exception $e){
	die($message."\n");
}
finally{
    $fh=fopen($argv[1], 'r');
    while($line=fgets($fh, 4096)){
	if(preg_match('/- name:/',$line)&&($name===false)){
		$vars[]=str_replace('- name:', '###>  ', $line);
	}

	if(preg_match('/{{/',$line)){
	    $v=true;
	    $var_part=explode('{{',$line);  ###>  
	    $var_temp=trim(str_replace('}}','',$var_part[1]));
	    $var_temp=trim(str_replace('"','',$var_temp));
	    $var_temp.=': ';
	    $vars[]=$var_temp;
	}
    }

    fclose($fh);
}
try{
	if($v===false){
	    throw new exception($e);
	}
}
catch(exception $e){
	die("The process failed to find any variables to write.\n");
}
finally{
    $vf=explode('/',$argv[1]);
    $cvf=count($vf);
    $vf_part=explode('.',$vf[$cvf - 1]);
    $vars_file=$vf_part[0].'_vars.yml';
    $vfile_R=readline("File:[$vars_file] will be created. Do you want to continue [Y/n]?\n");
    if(strtolower($vfile_R)!='n'){
        $fh=fopen($vars_file,'w');
        //fwrite($fh,$name."\n---\n");
        for($i=0;$i<count($vars);$i++){
	    if(!fwrite($fh,$vars[$i]."\n")){
		echo "There was a problem writing to vars file $vars_file.";
	    }else{
		echo "Adding entry for $vars[$i]\n";
	    }
	}
    }
}

?>
		
