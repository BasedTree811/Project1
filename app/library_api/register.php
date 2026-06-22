<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: *");
header("Content-Type: application/json");

include "db.php";

$surname = $_POST['surname'];
$name = $_POST['name'];
$email = $_POST['email'];
$login = $_POST['login'];
$password = $_POST['password'];

$check = "SELECT * FROM users
WHERE login='$login'";

$result = $connect->query($check);

if($result->num_rows > 0) {

    echo json_encode([

        "success" => false,
        "message" => "Логин уже существует"
    ]);

    exit();
}

$sql = "INSERT INTO users
(
surname,
name,
email,
login,
password,
role,
rating
)

VALUES
(
'$surname',
'$name',
'$email',
'$login',
'$password',
'user',
0
)";

if($connect->query($sql)) {

    echo json_encode([

        "success" => true,
        "message" => "Регистрация успешна"
    ]);

} else {

    echo json_encode([

        "success" => false,
        "message" => "Ошибка регистрации"
    ]);
}
?>