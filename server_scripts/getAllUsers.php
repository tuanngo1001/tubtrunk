<?php
include('connectDB.php');

$getQuery = "SELECT
                 FirstSet.uID,
                 FirstSet.uUserName,
                 FirstSet.uMoney,
                 FirstSet.avgMinutes,
                 FirstSet.totalMinutes,
                 FirstSet.totalTimes,
                 SecondSet.totalPrize
             FROM
                 (
                 SELECT
                     User.uID AS uID,
                     User.uUserName AS uUserName,
                     User.uMoney AS uMoney,
                     AVG(TimerRecord.trDuration) AS avgMinutes,
                     SUM(TimerRecord.trDuration) AS totalMinutes,
                     SUM(TimerRecord.trCompleted) AS totalTimes
                 FROM
                     User
                 LEFT JOIN TimerRecord ON User.uID = TimerRecord.uID AND TimerRecord.trCompleted = 1
                 GROUP BY
                     User.uID
             ) AS FirstSet
             LEFT JOIN(
                 SELECT
                     UserMissionProgress.uID AS userProgressID,
                     SUM(Mission.mPrize) AS totalPrize
                 FROM
                     Mission
                 LEFT JOIN UserMissionProgress ON UserMissionProgress.mID = Mission.mID AND UserMissionProgress.umpInProgress = 0
                 GROUP BY
                     UserMissionProgress.uID
             ) AS SecondSet
             ON
                 FirstSet.uID = SecondSet.userProgressID
             ORDER BY
                 FirstSet.uID";

$result = mysqli_query($con, $getQuery)  or die(mysqli_error($con));

$data = array();

while ($row = mysqli_fetch_assoc($result)) {
    $rowData = new stdClass();
    $rowData->ID = intval($row['uID']);
    $rowData->UserName = $row['uUserName'];
    $rowData->Prize = intval($row['uMoney']);
    $rowData->AverageMinutes = doubleval($row['avgMinutes']);
    $rowData->TotalMinutes = intval($row['totalMinutes']);
    $rowData->TotalTimes = intval($row['totalTimes']);
    $rowData->TotalPrize = intval($row['totalPrize']);
    array_push($data, $rowData);
}

$jsonData = json_encode($data);
die($jsonData);
die("Not found");
?>
