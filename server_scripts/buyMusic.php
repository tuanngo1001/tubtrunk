<?php
include('connectDB.php');

$couponID = $_POST['couponID'];

$deleteQuery = "UPDATE Music SET cIsBought = 1 WHERE id='$couponID'";

mysqli_query($con, $deleteQuery) or die(mysqli_error($con));
?>