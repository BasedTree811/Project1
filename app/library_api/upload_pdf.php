<?php

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: *");
header("Access-Control-Allow-Methods: *");
header("Content-Type: application/json");

$uploadDir = __DIR__ . "/uploads/";

if (!is_dir($uploadDir)) {
    mkdir($uploadDir, 0777, true);
}

if (!isset($_FILES["pdf"])) {
    echo json_encode([
        "success" => false,
        "message" => "Файл не передан"
    ]);
    exit;
}

$file = $_FILES["pdf"];

if ($file["error"] !== UPLOAD_ERR_OK) {
    $messages = [
        UPLOAD_ERR_INI_SIZE => "Файл слишком большой (лимит PHP)",
        UPLOAD_ERR_FORM_SIZE => "Файл слишком большой",
        UPLOAD_ERR_PARTIAL => "Файл загружен частично",
        UPLOAD_ERR_NO_FILE => "Файл не выбран",
    ];

    echo json_encode([
        "success" => false,
        "message" => $messages[$file["error"]] ?? "Ошибка загрузки файла"
    ]);
    exit;
}

$ext = strtolower(pathinfo($file["name"], PATHINFO_EXTENSION));

if ($ext !== "pdf") {
    echo json_encode([
        "success" => false,
        "message" => "Можно загружать только PDF"
    ]);
    exit;
}

$fileName = uniqid("book_", true) . ".pdf";
$targetPath = $uploadDir . $fileName;

if (move_uploaded_file($file["tmp_name"], $targetPath)) {

    $url = "http://127.0.0.1/library_api/uploads/$fileName";

    echo json_encode([
        "success" => true,
        "file_path" => $url,
        "message" => "PDF загружен"
    ]);

} else {

    echo json_encode([
        "success" => false,
        "message" => "Не удалось сохранить файл. Проверьте права на папку uploads"
    ]);
}
?>
