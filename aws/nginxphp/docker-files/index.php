<!DOCTYPE html>  
 <head>  
  <title>My website</title>
 </head>  
 <body>  
  <h1>Hello World! Changes were made. </h1>
  <p><?php echo 'Hi there: PHP ' . phpversion(); ?></p>
  <table>
   <tr><td>Hostname</td><td><?=$_SERVER['HOSTNAME'];?></td></tr>

   <tr><td>Server Software</td><td><?=$_ENV['SERVER_SOFTWARE'];?></td></tr>
 </table>
</body>
