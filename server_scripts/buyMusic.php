<?php
include('connectDB.php');

$userID = $_POST['UserID'];
$musicID = intval($_POST['MusicID']);

$query = "SELECT uOwnedMusics FROM User WHERE uID='$userID'";
$result = mysqli_query($con, $query) or die(mysqli_error($con));
if ($row = mysqli_fetch_assoc($result)) 
{
    if ($row['uOwnedMusics'] == "")
    {
        $musicIDs = [$musicID];
    }
    else
    {
        $musicIDs = json_decode($row['uOwnedMusics']);
        array_push($musicIDs, $musicID);
    }
    $jsonMusicIDs = json_encode($musicIDs);
    $query = "UPDATE User SET uOwnedMusics='$jsonMusicIDs' WHERE uID='$userID'";
    mysqli_query($con, $query) or die(mysqli_error($con));
}
?>