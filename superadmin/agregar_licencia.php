<?php
// superadmin/agregar_licencia.php
session_start();
require_once '../conecct/conex.php';

if (!isset($_SESSION['tipo']) || $_SESSION['tipo'] != 3) {
    header('Location: ../index.php');
    exit;
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $db = new Database();
    $con = $db->conectar();

    $usuario_asignado = $_POST['usuario_asignado'];
    $tipo_licencia = $_POST['tipo_licencia'];
    $fecha_inicio = $_POST['fecha_inicio'];
    $fecha_vencimiento = $_POST['fecha_vencimiento'];
    $max_usuarios = $_POST['max_usuarios'];
    $max_vehiculos = $_POST['max_vehiculos'];
    $estado = $_POST['estado'];
    $clave_licencia = $_POST['clave_licencia'] ?: null;

    try {
        $sql = $con->prepare("
            INSERT INTO sistema_licencias (usuario_asignado, tipo_licencia, fecha_inicio, fecha_vencimiento, max_usuarios, max_vehiculos, estado, clave_licencia)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        ");
        $sql->execute([$usuario_asignado, $tipo_licencia, $fecha_inicio, $fecha_vencimiento, $max_usuarios, $max_vehiculos, $estado, $clave_licencia]);
        header('Location: licencias.php?success=Licencia agregada correctamente');
    } catch (PDOException $e) {
        header('Location: licencias.php?error=Error al agregar licencia: ' . $e->getMessage());
    }
}
?>