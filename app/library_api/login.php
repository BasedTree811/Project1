<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: *");
header("Content-Type: application/json");

include "db.php";

$login = $_POST['login'];
$password = $_POST['password'];

$sql = "SELECT * FROM users

WHERE login='$login'
AND password='$password'";

$result = $connect->query($sql);

if($result->num_rows > 0) {

    $user = $result->fetch_assoc();

    $token = bin2hex(
        random_bytes(32)
    );

    $connect->query(

        "UPDATE users
        SET token='$token'

        WHERE id_user=" .
        $user['id_user']
    );

    $user['token'] = $token;

    echo json_encode([

        "success" => true,

        "user" => $user
    ]);

} else {

    echo json_encode([

        "success" => false,

        "message" =>
            "Неверный логин или пароль"
    ]);
}
?>