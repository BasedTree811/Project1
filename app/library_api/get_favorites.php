<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include "db.php";

$id_user = $_POST["id_user"] ?? "";

$sql = "
SELECT books.*
FROM favorites
JOIN books
ON favorites.id_book = books.id_book
WHERE favorites.id_user = '$id_user'
";

$result = mysqli_query($connect, $sql);

$data = [];

while($row = mysqli_fetch_assoc($result)){
    $data[] = $row;
}

echo json_encode($data);

?>