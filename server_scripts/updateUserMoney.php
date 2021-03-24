<?php
include('connectDB.php');

$userID = $_POST['UserID'];
$userMoney = $_POST['UserMoney'];

$updateQuery = "UPDATE User SET uMoney = '$userMoney' WHERE uID = '$userID'";
$result = mysqli_query($con, $updateQuery) or die(mysqli_error($con));
?>
