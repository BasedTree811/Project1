<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include "db.php";

$sql = "SELECT * FROM users";

$result = mysqli_query($connect, $sql);

$data = [];

while($row = mysqli_fetch_assoc($result)){

    $data[] = $row;
}

echo json_encode($data);
?>