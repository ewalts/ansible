<!DOCTYPE html>  
 <head>  
  <title>My website</title>
 </head>  
 <body>  
  <h1>Hello World! Changes were made. </h1>
  <p><?php echo 'Hi there: PHP ' . phpversion(); ?></p>
  <table>
   <th><td>Hostname</td><td><?=$_SERVER['HOSTNAME'];?></td></th>
   <th><td>Server Software</td><td><?=$_ENV['SERVER_SOFTWARE'];?></td></th>
 </table>
</body>
