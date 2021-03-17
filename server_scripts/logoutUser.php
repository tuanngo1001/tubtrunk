<?php
require_once('connectDB.php');
include('connectDB.php');

$con = $GLOBALS['con'];

$userEmail = $_POST['UserEmail'];

$updateQuery = "UPDATE User SET uToken = NULL WHERE uEmail = '$userEmail'";
$result = mysqli_query($con, $updateQuery);

die($result);
?>
