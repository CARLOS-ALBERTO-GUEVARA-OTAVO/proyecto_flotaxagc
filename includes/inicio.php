<?php
// Bloque PHP para manejo de autenticación de usuarios

session_start();
require_once('../conecct/conex.php');

// Conexión
$db = new Database();
$con = $db->conectar();

// Respuesta como JSON
header('Content-Type: application/json');

// Verificar que sea POST
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $doc = $_POST['doc'] ?? '';
    $passw = $_POST['passw'] ?? '';

    if (empty($doc) || empty($passw)) {
        echo json_encode(['status' => 'error', 'message' => 'Error: Todos los campos son obligatorios.']);
        exit;
    }

    // Buscar usuario
    $sql = $con->prepare("SELECT * FROM usuarios WHERE documento = ?");
    $sql->execute([$doc]);
    $fila = $sql->fetch();

    if (!$fila) {
        echo json_encode(['status' => 'error', 'message' => 'Error: Documento no encontrado.']);
        exit;
    }

    if (!password_verify($passw, $fila['password'])) {
        echo json_encode(['status' => 'error', 'message' => 'Error: Contraseña incorrecta.']);
        exit;
    }

    if ($fila['id_estado_usuario'] != 1 && $fila['id_rol'] != 3) {
        // Solo bloquea si no es superadmin
        echo json_encode(['status' => 'error', 'message' => 'Error: Usuario inactivo.']);
        exit;
    }

    // Validar licencia SOLO si es admin o usuario (NO superadmin)
    if ($fila['id_rol'] != 3) {
        $sqlLicencia = $con->prepare("SELECT * FROM sistema_licencias WHERE usuario_asignado = ? ORDER BY fecha_creacion DESC LIMIT 1");
        $sqlLicencia->execute([$fila['documento']]);
        $licencia = $sqlLicencia->fetch();

        $hoy = date('Y-m-d');

        if (!$licencia) {
            echo json_encode(['status' => 'error', 'message' => 'Error: No se encontró una licencia asociada.']);
            exit;
        }

        if ($licencia['estado'] !== 'activa') {
            echo json_encode(['status' => 'error', 'message' => 'Error: Su licencia está inactiva, suspendida o vencida.']);
            exit;
        }

        if ($hoy < $licencia['fecha_inicio'] || $hoy > $licencia['fecha_vencimiento']) {
            echo json_encode(['status' => 'error', 'message' => 'Error: La licencia está vencida.']);
            exit;
        }
    }

    // Crear sesión
    $_SESSION['documento'] = $fila['documento'];
    $_SESSION['tipo'] = $fila['id_rol'];

    // Determinar rol
    $rol = 'usuario';
    if ($fila['id_rol'] == 1) {
        $rol = 'admin';
    } elseif ($fila['id_rol'] == 3) {
        $rol = 'superadmin';
    }

    echo json_encode([
        'status' => 'success',
        'rol' => $rol
    ]);
} else {
    echo json_encode(['status' => 'error', 'message' => 'Petición no válida.']);
    exit;
}
?>
