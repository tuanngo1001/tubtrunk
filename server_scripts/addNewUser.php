<?php
require_once('connectDB.php');
include('connectDB.php');

$con = $GLOBALS['con'];

$userEmail = $_POST['UserEmail'];
$userPassword = $_POST['UserPassword'];


$getQuery = "SELECT * FROM User WHERE uEmail = '$userEmail'" ;
$result = mysqli_query($con, $getQuery) or die(mysqli_error($con));


while ($row = mysqli_fetch_assoc($result)) 
{
    die("Invalid");
}

$insertQuery = "
	INSERT INTO User (uEmail, uPassword)
	VALUES ('$userEmail', '$userPassword')";

//mysqli_query($con, $insertQuery) or die(mysqli_error($con));
if (mysqli_query($con, $insertQuery))
{
	die("Success");
}
else
{
	die(mysqli_error($con));
}
?>
