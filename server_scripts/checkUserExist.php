<?php
require_once('connectDB.php');

$con = $GLOBALS['con'];

function checkUser ($userEmail)
{
    $getQuery = "SELECT * FROM User WHERE uEmail = '$userEmail'" ;

    $result = mysqli_query($con, $getQuery);

    while ($row = mysqli_fetch_assoc($result)) 
    {
        return true;
    }
    return false;
}

die();
?>



