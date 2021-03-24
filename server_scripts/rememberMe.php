<?php
include('connectDB.php');

//get the posted user's info
$userEmail = $_POST['UserEmail'];
$userToken = $_POST['UserToken'];


$getQuery = "SELECT * FROM User WHERE uToken = '$userToken' AND uEmail = '$userEmail'" ;

$result = mysqli_query($con, $getQuery) or die(mysqli_error($con));
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

    $myUser = json_encode($user);
    die($myUser);
}
die("Not found");
?>



