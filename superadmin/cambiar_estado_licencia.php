<?php
// superadmin/cambiar_estado_licencia.php
session_start();

// Verifica que solo el superadministrador tenga acceso
if (!isset($_SESSION['tipo']) || $_SESSION['tipo'] != 3) {
    header("Location: ../index.php");
    exit();
}

// Verifica que se hayan recibido los datos del formulario
if (!isset($_POST['id_licencia']) || !isset($_POST['nuevo_estado'])) {
    $_SESSION['error'] = "Datos incompletos para cambiar el estado.";
    header("Location: licencias.php");
    exit();
}

require_once '../conecct/conex.php';

// Conexión a la base de datos
try {
    $db = new Database();
    $con = $db->conectar();
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    $_SESSION['error'] = "Error de conexión: " . $e->getMessage();
    header("Location: licencias.php");
    exit();
}

// Obtener datos del formulario
$id_licencia = $_POST['id_licencia'];
$nuevo_estado = $_POST['nuevo_estado'];

// Validar que el nuevo estado sea válido
$estados_validos = ['activa', 'suspendida'];
if (!in_array($nuevo_estado, $estados_validos)) {
    $_SESSION['error'] = "Estado inválido.";
    header("Location: licencias.php");
    exit();
}

// Validar que la licencia exista
try {
    $stmt = $con->prepare("SELECT id, estado FROM sistema_licencias WHERE id = ?");
    $stmt->execute([$id_licencia]);
    $licencia = $stmt->fetch(PDO::FETCH_ASSOC);

    if (!$licencia) {
        $_SESSION['error'] = "La licencia no existe.";
        header("Location: licencias.php");
        exit();
    }

    // Verificar si el estado ya es el mismo (evitar actualizaciones innecesarias)
    if ($licencia['estado'] === $nuevo_estado) {
        $_SESSION['error'] = "La licencia ya está en el estado '$nuevo_estado'.";
        header("Location: licencias.php");
        exit();
    }

    // Actualizar el estado de la licencia
    $stmt = $con->prepare("UPDATE sistema_licencias SET estado = ?, fecha_actualizacion = NOW() WHERE id = ?");
    $stmt->execute([$nuevo_estado, $id_licencia]);

    // Registrar la acción en logs_sistema
    $id_admin = $_SESSION['documento'];
    $accion = "Cambio de estado de licencia ID $id_licencia a '$nuevo_estado'";
    $ip = $_SERVER['REMOTE_ADDR'];
    $stmt = $con->prepare("INSERT INTO logs_sistema (id_usuario, accion, ip, fecha) VALUES (?, ?, ?, NOW())");
    $stmt->execute([$id_admin, $accion, $ip]);

    // Establecer mensaje de éxito
    $_SESSION['mensaje'] = "Estado de la licencia actualizado correctamente a '$nuevo_estado'.";
    header("Location: licencias.php");
    exit();

} catch (PDOException $e) {
    $_SESSION['error'] = "Error al actualizar el estado: " . $e->getMessage();
    header("Location: licencias.php");
    exit();
}
?>