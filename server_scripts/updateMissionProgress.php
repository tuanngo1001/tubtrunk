<?php
include('connectDB.php');

$userID = $_POST['UserID'];
$missionID = $_POST['MissionID'];
$inProgress = $_POST['InProgress'];
$progressTrack = $_POST['ProgressTrack'];

$updateQuery = "
    UPDATE UserMissionProgress
    SET umpInProgress = '$inProgress', umpProgressTrack = '$progressTrack'
    WHERE uID = '$userID' AND mID = '$missionID'";

$result = mysqli_query($con, $updateQuery) or die(mysqli_error($con));
?>