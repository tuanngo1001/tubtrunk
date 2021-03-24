<?php
require_once('connectDB.php');

$con = $GLOBALS['con'];

$userToken = $_POST['UserToken'];

$updateQuery = "UPDATE User SET uToken = NULL WHERE uToken = '$userToken'";
$result = mysqli_query($con, $updateQuery) or die(mysqli_error($con));

if($result)
{
    die("Success");
}
?>
