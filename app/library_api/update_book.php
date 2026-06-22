<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include "db.php";

$id_book = $_POST["id_book"] ?? $_POST["id"] ?? "";
$title = $_POST["title"] ?? "";
$author = $_POST["author"] ?? "";
$genre = $_POST["genre"] ?? "";
$description = $_POST["description"] ?? "";
$file_path = $_POST["file_path"] ?? "";

$sql = "UPDATE books SET
    title='$title',
    author='$author',
    genre='$genre',
    description='$description',
    file_path='$file_path'
    WHERE id_book='$id_book'";

if (mysqli_query($connect, $sql)) {

    echo json_encode([
        "success" => true,
        "message" => "Книга обновлена"
    ]);

} else {

    echo json_encode([
        "success" => false,
        "message" => mysqli_error($connect)
    ]);
}
?>
