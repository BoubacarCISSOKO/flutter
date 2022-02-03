<?php
   $host="localhost";
   $dbname="id17820606_mody";
   $user="id17820606_userflutter";
   $pass="eB!TUn9qBowI0o~i";

   try {
       //code...
       $db=new PDO("mysql:host=$host;dbname=$dbname",$user,$pass);
       echo ("connecté !");
   } catch (\Throwable $th) {
       //throw $th;
       echo "Error: ".$th->getMessage();
   }
?>