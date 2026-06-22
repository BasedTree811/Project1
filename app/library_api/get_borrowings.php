<?php

include "db.php";

$id_user = $_POST["id_user"];

$sql = "
SELECT
books.title,
borrowings.borrow_date,
borrowings.return_date
FROM borrowings
INNER JOIN books
ON books.id_book = borrowings.id_book
WHERE borrowings.id_user = '$id_user'
";

$result = mysqli_query(
    $connect,
    $sql
);

$data = [];

while($row = mysqli_fetch_assoc($result)){
    $data[] = $row;
}

echo json_encode($data);