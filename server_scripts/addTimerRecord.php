<?php
include('connectDB.php');

$userID = $_POST['UserID'];
$date = $_POST['Date'];
$time = $_POST['Time'];
$duration = $_POST['Duration'];
$completed = $_POST['Completed'];

$insertQuery = "
    INSERT INTO TimerRecord (uID, trDate, trTime, trDuration, trCompleted)
    VALUES ('$userID', '$date', '$time', '$duration', '$completed')";
mysqli_query($con, $insertQuery) or die(mysqli_error($con));
?>