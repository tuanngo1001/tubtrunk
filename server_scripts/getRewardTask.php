<?php
include('connectDB.php');

$getQuery = "SELECT * FROM RewardTask";

$result = mysqli_query($con, $getQuery);

$data = array();

while ($row = mysqli_fetch_assoc($result)) {
    $rowData = new stdClass();
    $rowData->ID = $row['id'];
    $rowData->Description = $row['description'];
    array_push($data, $rowData);
}

$jsonData = json_encode($data);
die($jsonData);




die("Not found");
?>



