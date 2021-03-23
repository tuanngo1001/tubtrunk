<?php
require_once('connectDB.php');

$con = $GLOBALS['con'];

//get the posted user's info
$userPassword = $_POST['UserPassword'];
$userEmail = $_POST['UserEmail'];

$getQuery = "SELECT * FROM User WHERE uPassword = '$userPassword' AND uEmail = '$userEmail'" ;

$result = mysqli_query($con, $getQuery);
$token = "";

while ($row = mysqli_fetch_assoc($result)) 
{
    //Generate a random unique token for "remember me functionality"
    $user = new stdClass();
    $user->uID = $row['uID'];
    $user->uEmail = $row['uEmail'];
    $user->uUserName = $row['uSerName'];
    $user->uPassword = $row['uPassword'];
    $user->uToken = $row['uToken'];
    $user->uMoney = $row['uMoney'];

    if ($row['uToken'] == null || $row['uToken'] == '')
    {
        $token = uniqid();
        $insertQuery = "UPDATE User SET uToken = '$token' WHERE uEmail = '$userEmail'";

        //If successfully insert new token, return it
        if (mysqli_query($con, $insertQuery))
        {
            $user->uToken = $token;
        }else
        {
            die(mysqli_error($con));
        }
    } 
    $myUser = json_decode($user);
    die($myUser);
}

die("Not found");
?>



