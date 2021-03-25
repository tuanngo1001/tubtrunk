<?php
include('connectDB.php');

$code = $_POST['Code'];
$store = $_POST['Store'];
$discount = $_POST['Discount'];
$description = $_POST['Description'];
$date = date_create($_POST['ExpiryDate']);
$expiryDate = date_format($date, "Y-m-d");

$insertQuery = "
    INSERT INTO Coupon (code, store, discount, description, cExpiryDate)
    VALUES ('$code', '$store', '$discount', '$description', '$expiryDate')";
mysqli_query($con, $insertQuery) or die(mysqli_error($con));

header('Location: http://tubtrunk.tk/coupon_form.html');
?>