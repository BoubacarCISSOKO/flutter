<?php 
  $db = "id17820606_mody"; //database name
   $dbuser = "id17820606_userflutter"; //database username
   $dbpassword = "eB!TUn9qBowI0o~i"; //database password
   $dbhost = "localhost"; //database host
   $port = 21;
$return["error"] = false;
   $return["message"] = "";

try {
    $conn = new PDO("mysql:host=" . $dbhost. ";dbname=" .$db .";port=".$port,$dbuser,$dbpassword);
    // set the PDO error mode to exception
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $name = $_POST["name"]; //grabing the data from headers
    $email = $_POST["email"];
    $pass = $_POST["pass"];
  $sql = "INSERT INTO users (name, email, pass)
  VALUES ('$name','$email','$pass')";
  // use exec() because no results are returned
  $conn->exec($sql);
  echo "New record created successfully";
} catch(PDOException $e) {
  echo $sql . "<br>" . $e->getMessage();
}

$conn = null;


?>