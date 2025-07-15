<?php
// superadmin/eliminar_licencia.php
session_start();
require_once '../conecct/conex.php';

if (!isset($_SESSION['tipo']) || $_SESSION['tipo'] != 3) {
    header('Location: ../index.php');
    exit;
}

$id = $_GET['id'];
$db = new Database();
$con = $db->conectar();

try {
    $sql = $con->prepare("DELETE FROM sistema_licencias WHERE id = ?");
    $sql->execute([$id]);
    header('Location: licencias.php?success=Licencia eliminada correctamente');
} catch (PDOException $e) {
    header('Location: licencias.php?error=Error al eliminar licencia: ' . $e->getMessage());
}
?>