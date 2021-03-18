<?php
require_once('connectDB.php');
include('connectDB.php');
include('checkUserExist.php');

$con = $GLOBALS['con'];

$userEmail = $_POST['UserEmail'];
$userName = $_POST['UserName'];

if (checkUser($userEmail))
{
    $updateQuery = "UPDATE User SET uUserName = '$userName' WHERE uEmail = '$userEmail'";
    $result = mysqli_query($con, $updateQuery);
    
    die($result);
}
die("Not found");
?>
