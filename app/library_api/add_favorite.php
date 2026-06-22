<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include "db.php";

$id_user = $_POST["id_user"];
$id_book = $_POST["id_book"];

$sql = "INSERT INTO favorites
(id_user, id_book)

VALUES
('$id_user', '$id_book')";

if(mysqli_query($connect, $sql)){

    echo json_encode([
        "success" => true,
        "message" => "Добавлено в избранное"
    ]);

}else{

    echo json_encode([
        "success" => false,
        "message" => mysqli_error($connect)
    ]);
}
?>