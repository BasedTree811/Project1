<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

include "db.php";

$id_user = $_POST["id_user"];
$id_book = $_POST["id_book"];

$sql = "INSERT INTO history(id_user,id_book)
VALUES('$id_user','$id_book')";

if(mysqli_query($connect,$sql)){
	
    mysqli_query(
    $connect,
    "UPDATE users
     SET rating = rating + 1
     WHERE id_user = '$id_user'"
);
    echo json_encode([
        "success"=>true
    ]);

}else{

    echo json_encode([
        "success"=>false
    ]);
}
?>