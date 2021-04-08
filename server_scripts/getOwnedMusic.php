<?php
include('connectDB.php');

$userID = $_POST['UserID'];

$query = "SELECT uOwnedMusics FROM User WHERE uID='$userID'";
$result = mysqli_query($con, $query) or die(mysqli_error($con));
$musicIDs = [];
if ($row = mysqli_fetch_assoc($result)) 
{
    if ($row['uOwnedMusics'] != "")
    {
        $debug = "INSERT INTO Debug (dDesc) VALUES ('Do have')";
        mysqli_query($con, $debug);

        $musicIDs = json_decode($row['uOwnedMusics']);
    }
}

$getQuery = "SELECT * FROM Music";
$result = mysqli_query($con, $getQuery);

mysqli_query($con, $debug);

$data = array();
while ($row = mysqli_fetch_assoc($result))
{
    $rowData = new stdClass();
    $rowData->ID = intval($row['msID']);

    $found = false;
    for ($i = 0; $i < count($musicIDs) && !$found; $i++)
    {
        if ($rowData->ID == $musicIDs[$i])
        {
            $found = true;
        }
    }

    if ($found)
    {
        $rowData->Title = $row['msTitle'];
        $rowData->FileName = $row['msFileName'];
    
        array_push($data, $rowData);
    }
}

$jsonData = json_encode($data);
die($jsonData);
?>