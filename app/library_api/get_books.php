<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: *");
header("Content-Type: application/json");
header("Content-Type: application/json");

include "db.php";

$sql = "SELECT * FROM books";

$result = $connect->query($sql);

$books = [];

while($row = $result->fetch_assoc()){

    $books[] = $row;
}

echo json_encode($books);
?>