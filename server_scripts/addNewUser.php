<?php
include('connectDB.php');


$userEmail = $_POST['UserEmail'];
$userPassword = $_POST['UserPassword'];
$userName = $_POST['UserName'];


$getQuery = "SELECT * FROM User WHERE uEmail = '$userEmail'" ;
$result = mysqli_query($con, $getQuery) or die(mysqli_error($con));


while ($row = mysqli_fetch_assoc($result)) 
{
    die("Invalid");
}

$insertQuery = "
	INSERT INTO User (uEmail, uPassword, uUserName)
	VALUES ('$userEmail', '$userPassword', '$userName')"; 	

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
