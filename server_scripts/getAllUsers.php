<?php
include('connectDB.php');

$getQuery = "SELECT uID, uUserName, uEmail, uMoney FROM User ORDER BY uMoney DESC";

$result = mysqli_query($con, $getQuery)  or die(mysqli_error($con));

$data = array();

while ($row = mysqli_fetch_assoc($result)) {
    $rowData = new stdClass();
    $rowData->ID = intval($row['uID']);
    $rowData->UserName = $row['uUserName'];
    $rowData->Email = $row['uEmail'];
    $rowData->Prize = intval($row['uMoney']);

    array_push($data, $rowData);
}

$jsonData = json_encode($data);
die($jsonData);

die("Not found");
?>

