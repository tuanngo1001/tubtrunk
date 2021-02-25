<?php
include('connectDB.php');

$userID = $_POST['UserID'];

$debug = "INSERT INTO Debug (dDesc) VALUES ('ID = {$userID}')";
mysqli_query($con, $debug);

$getQuery = "SELECT * FROM TimerRecord WHERE uID = '$userID'";
$result = mysqli_query($con, $getQuery) or die(mysqli_error($con));

$timerRecords = array();
while ($row = mysqli_fetch_assoc($result))
{
    $timerRecord = new stdClass();
    $timerRecord->Date = $row['trDate'];
    $timerRecord->Time = $row['trTime'];
    $timerRecord->Duration = $row['trDuration'];
    $timerRecord->Completed = $row['trCompleted'];
    $timerRecord->Tag = $row['trTag'];

    array_push($timerRecords, $timerRecord);
}

$jsonData = json_encode($timerRecords);
die($jsonData);

?>