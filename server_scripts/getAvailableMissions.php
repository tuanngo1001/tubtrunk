<?php
include('connectDB.php');

$userID = $_POST['UserID'];

$getQuery = "
    SELECT * FROM Mission
    WHERE mID NOT IN (
        SELECT mID FROM UserMissionProgress
        WHERE uID = '$userID'
    )";
$result = mysqli_query($con, $getQuery) or die(mysqli_error($con));

$missions = array();
while ($row = mysqli_fetch_assoc($result))
{
    $mission = new stdClass();
    $mission->ID = intval($row['mID']);
    $mission->Title = $row['mTitle'];
    $mission->Prize = intval($row['mPrize']);
    $mission->Requirements = json_decode($row['mRequirements']);
    $mission->InProgress = false;
    $mission->ProgressTrack = [];

    array_push($missions, $mission);
}

$jsonData = json_encode($missions);
die($jsonData);

?>