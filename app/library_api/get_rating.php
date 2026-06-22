<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include "db.php";

$sql = "
SELECT
name,
login,
rating
FROM users
ORDER BY rating DESC
";

$result = mysqli_query($connect, $sql);

$data = [];

while($row = mysqli_fetch_assoc($result)){
    $data[] = $row;
}

echo json_encode($data);