<?php
include('connectDB.php');

$title = $_POST['Title'];
$prize = $_POST['Prize'];
$minutes1 = $_POST['Minutes1'];
$minutes2 = $_POST['Minutes2'];
$minutes3 = $_POST['Minutes3'];
$minutes4 = $_POST['Minutes4'];
$times1 = $_POST['Times1'];
$times2 = $_POST['Times2'];
$times3 = $_POST['Times3'];
$times4 = $_POST['Times4'];
$requirements = "[[{$minutes1}, {$times1}], [{$minutes2}, {$times2}], [{$minutes3}, {$times3}], [{$minutes4}, {$times4}]]";

$insertQuery = "
    INSERT INTO Mission (mTitle, mPrize, mRequirements)
    VALUES ('$title', '$prize', '$requirements')";
mysqli_query($con, $insertQuery) or die(mysqli_error($con));

header('Location: http://tubtrunk.tk/mission_form.html');
?>