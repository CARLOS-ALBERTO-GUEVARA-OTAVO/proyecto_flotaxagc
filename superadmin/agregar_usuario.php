<?php
session_start();
require_once('../conecct/conex.php');

if (!isset($_SESSION['tipo']) || $_SESSION['tipo'] != 3) {
    header('Location: ../index.php');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $db = new Database();
    $con = $db->conectar();

    $documento = $_POST['documento'];
    $nombre_completo = $_POST['nombre_completo'];
    $email = $_POST['email'];
    $password = password_hash($_POST['password'], PASSWORD_BCRYPT);
    $telefono = $_POST['telefono'];
    $id_rol = $_POST['id_rol'];
    $id_estado_usuario = $_POST['id_estado_usuario'];

    try {
        $sql = $con->prepare("INSERT INTO usuarios (documento, nombre_completo, email, password, telefono, id_rol, id_estado_usuario) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $sql->execute([$documento, $nombre_completo, $email, $password, $telefono, $id_rol, $id_estado_usuario]);
        header('Location: usuarios.php?success=Usuario agregado correctamente');
    } catch (PDOException $e) {
        header('Location: usuarios.php?error=Error al agregar usuario: ' . $e->getMessage());
    }
}
?>