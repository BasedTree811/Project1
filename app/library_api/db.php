<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: *");
header("Content-Type: application/json");

$host = "localhost";
$user = "root";
$password = "";
$database = "electronic_library";

$connect = mysqli_connect(
    $host,
    $user,
    $password,
    $database
);

if(!$connect){

    die(json_encode([
        "success" => false,
        "message" => "Ошибка подключения к БД"
    ]));
}

mysqli_set_charset($connect, "utf8");
?>