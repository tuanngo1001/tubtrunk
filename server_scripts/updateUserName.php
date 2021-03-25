<?php
include('connectDB.php');

$userEmail = $_POST['UserEmail'];
$userName = $_POST['UserName'];

$getQuery = "SELECT * FROM User WHERE uEmail = '$userEmail'" ;

$result = mysqli_query($con, $getQuery) or die(mysqli_error($con));

while ($row = mysqli_fetch_assoc($result)) 
{
    if(strcmp($userName,$row['uUserName']) == 0)
    {
        die("Existed");
    }

    $updateQuery = "UPDATE User SET uUserName = '$userName' WHERE uEmail = '$userEmail'";
    $result = mysqli_query($con, $updateQuery) or die(mysqli_error($con));

    die("Success");
}
?>
