<?php
include('connectDB.php');

$couponID = $_POST['couponID'];

$deleteQuery = "DELETE FROM Coupon WHERE id='$couponID'";

mysqli_query($con, $deleteQuery) or die(mysqli_error($con));
?>