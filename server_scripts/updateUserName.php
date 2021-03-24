<?php
include('connectDB.php');

$userEmail = $_POST['UserEmail'];
$userName = $_POST['UserName'];

$getQuery = "SELECT * FROM User WHERE uEmail = '$userEmail'" ;

$result = mysqli_query($con, $getQuery);

while ($row = mysqli_fetch_assoc($result)) 
{
    $updateQuery = "UPDATE User SET uUserName = '$userName' WHERE uEmail = '$userEmail'";
    $result = mysqli_query($con, $updateQuery);
    
    if($result)
    {
        die("Success");
    }
    die("Error");
}

die("Not found");
?>
