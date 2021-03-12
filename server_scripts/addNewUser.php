<?php
require_once('connectDB.php');
include('connectDB.php');

$con = $GLOBALS['con'];


$userFirstName = $_POST['UserFirstName'];
$userLastName = $_POST['UserLastName'];
$userEmail = $_POST['UserEmail'];
$userPassword = $_POST['UserPassword'];
$userName = $_POST['UserName'];

$getQuery = "SELECT * FROM User WHERE uEmail = '$userEmail'" ;
$result = mysqli_query($con, $getQuery);


while ($row = mysqli_fetch_assoc($result)) {
    die("Already Exist");
}

$insertQuery = "
	INSERT INTO User (uFirstName, uLastName, uEmail, uPassword, uUserName)
	VALUES ('$userFirstName', '$userLastName', '$userEmail', '$userPassword','$userName')";

//mysqli_query($con, $insertQuery) or die(mysqli_error($con));
if(mysqli_query($con, $insertQuery)){
	die("Success");
}
die("Not found");
?>
