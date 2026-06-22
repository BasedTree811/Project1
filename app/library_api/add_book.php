<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include "db.php";

$title = $_POST["title"] ?? "";
$author = $_POST["author"] ?? "";
$genre = $_POST["genre"] ?? "";
$description = $_POST["description"] ?? "";
$file_path = $_POST["file_path"] ?? "";

$sql = "INSERT INTO books
(title, author, genre, description, file_path)
VALUES
('$title','$author','$genre','$description','$file_path')";

if(mysqli_query($connect, $sql)){

    echo json_encode([
        "success" => true,
        "message" => "Книга добавлена"
    ]);

}else{

    echo json_encode([
        "success" => false,
        "message" => mysqli_error($connect)
    ]);
}