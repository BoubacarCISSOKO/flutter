<?php 

  $db = "id17820606_mody"; //database name
  $dbuser = "id17820606_userflutter"; //database username
  $dbpassword = "eB!TUn9qBowI0o~i"; //database password
  $dbhost = "localhost"; //database host

  $return["error"] = false;
  $return["message"] = "";

  $db=new PDO("mysql:host=$dbhost;dbname=$db",$dbuser,$dbpassword);

  //connecting to database server

  $val = isset($_POST["name"]) && isset($_POST["address"])
         && isset($_POST["class"]) && isset($_POST["rollno"]);

  if($val){
       //checking if there is POST data

       $name = $_POST["name"]; //grabing the data from headers
       $address = $_POST["address"];
       $class = $_POST["class"];
       $rollno = $_POST["rollno"];

       $req = $db->prepare("INSERT INTO test_db VALUES (null,?,?,?,?)");
       $req = execute(array($name,$address,$class,$rollno));
        //write success
          if ($req){
              $succes=1;
              $msg="bien enrégistré";

          }else{
              $succes=0;
              $msg="erreur";
          }


  }else{
      $return["error"] = true;
      $return["message"] = 'Send all parameters.';
  }

  mysqli_close($db); //close mysqli

  header('Content-Type: application/json');
  // tell browser that its a json data
  echo json_encode($return);
  //converting array to JSON string
?>