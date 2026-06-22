<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include "db.php";

$id = $_POST["id_book"] ?? $_POST["id"] ?? "";

$sql = "DELETE FROM books
WHERE id_book='$id'";

if(mysqli_query($connect, $sql)){

    echo json_encode([
        "success" => true,
        "message" => "Книга удалена"
    ]);

}else{

    echo json_encode([
        "success" => false,
        "message" => mysqli_error($connect)
    ]);
}
?>