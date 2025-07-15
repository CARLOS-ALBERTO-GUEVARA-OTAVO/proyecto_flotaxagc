<?php
// superadmin/editar_licencia.php
session_start();
require_once '../conecct/conex.php';

if (!isset($_SESSION['tipo']) || $_SESSION['tipo'] != 3) {
    header('Location: ../index.php');
    exit;
}

$db = new Database();
$con = $db->conectar();

$id = $_GET['id'];
$sql = $con->prepare("SELECT * FROM sistema_licencias WHERE id = ?");
$sql->execute([$id]);
$licencia = $sql->fetch(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
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
            UPDATE sistema_licencias
            SET usuario_asignado = ?, tipo_licencia = ?, fecha_inicio = ?, fecha_vencimiento = ?, max_usuarios = ?, max_vehiculos = ?, estado = ?, clave_licencia = ?
            WHERE id = ?
        ");
        $sql->execute([$usuario_asignado, $tipo_licencia, $fecha_inicio, $fecha_vencimiento, $max_usuarios, $max_vehiculos, $estado, $clave_licencia, $id]);
        header('Location: licencias.php?success=Licencia actualizada correctamente');
    } catch (PDOException $e) {
        header('Location: licencias.php?error=Error al actualizar licencia: ' . $e->getMessage());
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Licencia</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Editar Licencia</h2>
        <form action="" method="POST">
            <div class="mb-3">
                <label for="usuario_asignado" class="form-label">Usuario Asignado</label>
                <select class="form-select" id="usuario_asignado" name="usuario_asignado" required>
                    <?php
                    $usuarios = $con->query("SELECT documento, nombre_completo FROM usuarios WHERE id_estado_usuario = 1")->fetchAll(PDO::FETCH_ASSOC);
                    foreach ($usuarios as $usuario) {
                        $selected = $usuario['documento'] == $licencia['usuario_asignado'] ? 'selected' : '';
                        echo "<option value='{$usuario['documento']}' $selected>{$usuario['nombre_completo']} ({$usuario['documento']})</option>";
                    }
                    ?>
                </select>
            </div>
            <div class="mb-3">
                <label for="tipo_licencia" class="form-label">Tipo de Licencia</label>
                <select class="form-select" id="tipo_licencia" name="tipo_licencia" required>
                    <option value="basica" <?= $licencia['tipo_licencia'] == 'basica' ? 'selected' : '' ?>>Básica</option>
                    <option value="profesional" <?= $licencia['tipo_licencia'] == 'profesional' ? 'selected' : '' ?>>Profesional</option>
                    <option value="empresarial" <?= $licencia['tipo_licencia'] == 'empresarial' ? 'selected' : '' ?>>Empresarial</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="fecha_inicio" class="form-label">Fecha de Inicio</label>
                <input type="date" class="form-control" id="fecha_inicio" name="fecha_inicio" value="<?= htmlspecialchars($licencia['fecha_inicio']) ?>" required>
            </div>
            <div class="mb-3">
                <label for="fecha_vencimiento" class="form-label">Fecha de Vencimiento</label>
                <input type="date" class="form-control" id="fecha_vencimiento" name="fecha_vencimiento" value="<?= htmlspecialchars($licencia['fecha_vencimiento']) ?>" required>
            </div>
            <div class="mb-3">
                <label for="max_usuarios" class="form-label">Máximo de Usuarios</label>
                <input type="number" class="form-control" id="max_usuarios" name="max_usuarios" min="1" value="<?= htmlspecialchars($licencia['max_usuarios']) ?>" required>
            </div>
            <div class="mb-3">
                <label for="max_vehiculos" class="form-label">Máximo de Vehículos</label>
                <input type="number" class="form-control" id="max_vehiculos" name="max_vehiculos" min="1" value="<?= htmlspecialchars($licencia['max_vehiculos']) ?>" required>
            </div>
            <div class="mb-3">
                <label for="estado" class="form-label">Estado</label>
                <select class="form-select" id="estado" name="estado" required>
                    <option value="activa" <?= $licencia['estado'] == 'activa' ? 'selected' : '' ?>>Activa</option>
                    <option value="vencida" <?= $licencia['estado'] == 'vencida' ? 'selected' : '' ?>>Vencida</option>
                    <option value="suspendida" <?= $licencia['estado'] == 'suspendida' ? 'selected' : '' ?>>Suspendida</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="clave_licencia" class="form-label">Clave de Licencia</label>
                <input type="text" class="form-control" id="clave_licencia" name="clave_licencia" value="<?= htmlspecialchars($licencia['clave_licencia'] ?? '') ?>">
            </div>
            <button type="submit" class="btn btn-primary">Actualizar</button>
            <a href="licencias.php" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>