<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include "db.php";

$id_user = $_POST["id_user"] ?? "";

$sql = "
SELECT books.*
FROM history
JOIN books
ON history.id_book = books.id_book
WHERE history.id_user = '$id_user'
ORDER BY history.id DESC
";

$result = mysqli_query($connect,$sql);

$data = [];

while($row = mysqli_fetch_assoc($result)){
    $data[] = $row;
}

echo json_encode($data);