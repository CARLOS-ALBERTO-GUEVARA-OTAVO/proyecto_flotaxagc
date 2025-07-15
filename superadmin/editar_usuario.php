<?php
session_start();
require_once('../conecct/conex.php');

if (!isset($_SESSION['tipo']) || $_SESSION['tipo'] != 3) {
    header('Location: ../index.php');
    exit;
}

$db = new Database();
$con = $db->conectar();

$documento = $_GET['documento'];
$sql = $con->prepare("SELECT * FROM usuarios WHERE documento = ?");
$sql->execute([$documento]);
$usuario = $sql->fetch(PDO::FETCH_ASSOC);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nombre_completo = $_POST['nombre_completo'];
    $email = $_POST['email'];
    $telefono = $_POST['telefono'];
    $id_rol = $_POST['id_rol'];
    $id_estado_usuario = $_POST['id_estado_usuario'];

    try {
        $sql = $con->prepare("UPDATE usuarios SET nombre_completo = ?, email = ?, telefono = ?, id_rol = ?, id_estado_usuario = ? WHERE documento = ?");
        $sql->execute([$nombre_completo, $email, $telefono, $id_rol, $id_estado_usuario, $documento]);
        header('Location: usuarios.php?success=Usuario actualizado correctamente');
    } catch (PDOException $e) {
        header('Location: usuarios.php?error=Error al actualizar usuario: ' . $e->getMessage());
    }
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Editar Usuario</h2>
        <form action="" method="POST">
            <div class="mb-3">
                <label for="documento" class="form-label">Documento</label>
                <input type="text" class="form-control" id="documento" value="<?= htmlspecialchars($usuario['documento']) ?>" disabled>
            </div>
            <div class="mb-3">
                <label for="nombre_completo" class="form-label">Nombre Completo</label>
                <input type="text" class="form-control" id="nombre_completo" name="nombre_completo" value="<?= htmlspecialchars($usuario['nombre_completo']) ?>" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Correo</label>
                <input type="email" class="form-control" id="email" name="email" value="<?= htmlspecialchars($usuario['email']) ?>" required>
            </div>
            <div class="mb-3">
                <label for="telefono" class="form-label">Teléfono</label>
                <input type="text" class="form-control" id="telefono" name="telefono" value="<?= htmlspecialchars($usuario['telefono']) ?>" required>
            </div>
            <div class="mb-3">
                <label for="id_rol" class="form-label">Rol</label>
                <select class="form-select" id="id_rol" name="id_rol" required>
                    <?php
                    $roles = $con->query("SELECT * FROM roles")->fetchAll(PDO::FETCH_ASSOC);
                    foreach ($roles as $rol) {
                        $selected = $rol['id_rol'] == $usuario['id_rol'] ? 'selected' : '';
                        echo "<option value='{$rol['id_rol']}' $selected>{$rol['tip_rol']}</option>";
                    }
                    ?>
                </select>
            </div>
            <div class="mb-3">
                <label for="id_estado_usuario" class="form-label">Estado</label>
                <select class="form-select" id="id_estado_usuario" name="id_estado_usuario" required>
                    <?php
                    $estados = $con->query("SELECT * FROM estado_usuario")->fetchAll(PDO::FETCH_ASSOC);
                    foreach ($estados as $estado) {
                        $selected = $estado['id_estado'] == $usuario['id_estado_usuario'] ? 'selected' : '';
                        echo "<option value='{$estado['id_estado']}' $selected>{$estado['tipo_stade']}</option>";
                    }
                    ?>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Actualizar</button>
            <a href="usuarios.php" class="btn btn-secondary">Cancelar</a>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>