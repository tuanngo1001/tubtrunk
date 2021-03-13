<?php
include('connectDB.php');

$userID = $_POST['UserID'];

$getQuery = "
    SELECT *
    FROM (
        UserMissionProgress as UMP
        INNER JOIN Mission AS M ON M.mID = UMP.mID)
    WHERE uID = '$userID'";

$result = mysqli_query($con, $getQuery) or die(mysqli_error($con));

$missions = array();
while ($row = mysqli_fetch_assoc($result))
{
    $mission = new stdClass();
    $mission->ID = $row['mID'];
    $mission->Title = $row['mTitle'];
    $mission->Prize = intval($row['mPrize']);
    $mission->Requirements = json_decode($row['mRequirements']);
    $mission->InProgress = boolval($row['umpInProgress']);
    $mission->ProgressTrack = json_decode($row['umpProgressTrack']);

    array_push($missions, $mission);
}

$jsonData = json_encode($missions);
die($jsonData);

?>