<?php
session_start();
require_once('../conecct/conex.php');

if (!isset($_SESSION['tipo']) || $_SESSION['tipo'] != 3) {
    header('Location: ../index.php');
    exit;
}

$documento = $_GET['documento'];
$db = new Database();
$con = $db->conectar();

try {
    $sql = $con->prepare("DELETE FROM usuarios WHERE documento = ?");
    $sql->execute([$documento]);
    header('Location: usuarios.php?success=Usuario eliminado correctamente');
} catch (PDOException $e) {
    header('Location: usuarios.php?error=Error al eliminar usuario: ' . $e->getMessage());
}
?>