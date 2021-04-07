<?php
include('connectDB.php');

$getQuery = "SELECT * FROM Music";
$result = mysqli_query($con, $getQuery);

$data = array();
while ($row = mysqli_fetch_assoc($result)) {
    $rowData = new stdClass();
    $rowData->ID = $row['msID'];
    $rowData->Title = $row['msTitle'];
    $rowData->FileName = $row['msFileName'];

    array_push($data, $rowData);
}

$jsonData = json_encode($data);
die($jsonData);
?>