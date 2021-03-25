<?php
include('connectDB.php');

$userToken = $_POST['UserToken'];

$updateQuery = "UPDATE User SET uToken = NULL WHERE uToken = '$userToken'";
$result = mysqli_query($con, $updateQuery) or die(mysqli_error($con));

if($result)
{
    die("Success");
}
?>
