<?php
include('connectDB.php');

$getQuery = "SELECT * FROM Coupon WHERE cIsBought = 0";

$result = mysqli_query($con, $getQuery);

$data = array();

while ($row = mysqli_fetch_assoc($result)) {
    $rowData = new stdClass();
    $rowData->ID = $row['id'];
    $rowData->Code = $row['code'];
    $rowData->Store = $row['store'];
    $rowData->Discount = $row['discount'];
    $rowData->Description = $row['description'];
    $rowData->ExpireDate = $row['cExpiryDate'];

    array_push($data, $rowData);
}

$jsonData = json_encode($data);
die($jsonData);
?>



