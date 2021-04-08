<?php
include('connectDB.php');

$couponID = $_POST['couponID'];

$updateQuery = "UPDATE Coupon SET cIsBought = 1 WHERE id='$couponID'";

mysqli_query($con, $updateQuery) or die(mysqli_error($con));
?>