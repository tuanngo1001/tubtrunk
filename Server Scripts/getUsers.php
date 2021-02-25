<?php
require_once('connectDB.php');

$con = $GLOBALS['con'];

$getQuery = "SELECT * FROM User";

$result = mysqli_query($con, $getQuery);

$data = array();

while ($row = mysqli_fetch_assoc($result)) {
    $rowData = new stdClass();
    $rowData->uID = $row['uID'];
    $rowData->Name = $row['uFirstName'] . " " . $row['uLastName'];
    $rowData->uEmail = $row['uEmail'];

    array_push($data, $rowData);
}

$jsonData = json_encode($data);
die($jsonData);

die("Not found");
?>



