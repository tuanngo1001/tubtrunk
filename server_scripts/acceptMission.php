<?php
include('connectDB.php');

$userID = $_POST['UserID'];
$missionID = $_POST['MissionID'];

$insertQuery = "
    INSERT INTO UserMissionProgress (uID, mID, umpInProgress, umpProgressTrack)
    VALUES ('$userID', '$missionID', '1', '[0, 0, 0, 0]')";

$result = mysqli_query($con, $insertQuery) or die(mysqli_error($con));
?>