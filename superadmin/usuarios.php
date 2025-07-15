<?php
// superadmin/usuarios.php
session_start();
require_once('../conecct/conex.php');

// Verifica si el usuario tiene rol de superadmin
if (!isset($_SESSION['tipo']) || $_SESSION['tipo'] != 3) {
    header('Location: ../index.php');
    exit;
}

// Conexión a la base de datos
try {
    $db = new Database();
    $con = $db->conectar();
    $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Error de conexión: " . $e->getMessage());
}

// Configuración de paginación
$por_pagina = 10;
$pagina_actual = isset($_GET['pagina']) ? (int)$_GET['pagina'] : 1;
$offset = ($pagina_actual - 1) * $por_pagina;

// Consulta para obtener usuarios con JOIN a roles y estado_usuario
try {
    $sql_total = $con->query("SELECT COUNT(*) as total FROM usuarios");
    $total_usuarios = $sql_total->fetch(PDO::FETCH_ASSOC)['total'];
    $total_paginas = ceil($total_usuarios / $por_pagina);

    $sql = $con->query("
        SELECT u.documento, u.nombre_completo, u.email, r.tip_rol, eu.tipo_stade
        FROM usuarios u
        INNER JOIN roles r ON u.id_rol = r.id_rol
        INNER JOIN estado_usuario eu ON u.id_estado_usuario = eu.id_estado
        LIMIT $offset, $por_pagina
    ");
    $usuarios = $sql->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("Error en la consulta: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Usuarios</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/css/estilos.css">
    <style>
        body { padding: 20px; }
        .table-responsive { margin-top: 20px; }
        .pagination { justify-content: center; margin-top: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="mb-4">Gestión de Usuarios</h2>

        <!-- Botón para abrir el formulario de agregar usuario -->
        <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addUserModal">
            Agregar Usuario
        </button>

        <!-- Tabla de usuarios -->
        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>Documento</th>
                        <th>Nombre</th>
                        <th>Correo</th>
                        <th>Rol</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($usuarios as $user): ?>
                        <tr>
                            <td><?= htmlspecialchars($user['documento']) ?></td>
                            <td><?= htmlspecialchars($user['nombre_completo']) ?></td>
                            <td><?= htmlspecialchars($user['email']) ?></td>
                            <td><?= htmlspecialchars($user['tip_rol']) ?></td>
                            <td><?= htmlspecialchars($user['tipo_stade']) ?></td>
                            <td>
                                <a href="editar_usuario.php?documento=<?= urlencode($user['documento']) ?>" class="btn btn-sm btn-warning">Editar</a>
                                <a href="eliminar_usuario.php?documento=<?= urlencode($user['documento']) ?>" class="btn btn-sm btn-danger" onclick="return confirm('¿Estás seguro de eliminar este usuario?')">Eliminar</a>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>

        <!-- Paginación -->
        <nav>
            <ul class="pagination">
                <?php if ($pagina_actual > 1): ?>
                    <li class="page-item">
                        <a class="page-link" href="?pagina=<?= $pagina_actual - 1 ?>">Anterior</a>
                    </li>
                <?php endif; ?>
                <?php for ($i = 1; $i <= $total_paginas; $i++): ?>
                    <li class="page-item <?= $i == $pagina_actual ? 'active' : '' ?>">
                        <a class="page-link" href="?pagina=<?= $i ?>"><?= $i ?></a>
                    </li>
                <?php endfor; ?>
                <?php if ($pagina_actual < $total_paginas): ?>
                    <li class="page-item">
                        <a class="page-link" href="?pagina=<?= $pagina_actual + 1 ?>">Siguiente</a>
                    </li>
                <?php endif; ?>
            </ul>
        </nav>
    </div>

    <!-- Modal para agregar usuario -->
    <div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addUserModalLabel">Agregar Nuevo Usuario</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="agregar_usuario.php" method="POST">
                        <div class="mb-3">
                            <label for="documento" class="form-label">Documento</label>
                            <input type="text" class="form-control" id="documento" name="documento" required>
                        </div>
                        <div class="mb-3">
                            <label for="nombre_completo" class="form-label">Nombre Completo</label>
                            <input type="text" class="form-control" id="nombre_completo" name="nombre_completo" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Correo</label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Contraseña</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <div class="mb-3">
                            <label for="telefono" class="form-label">Teléfono</label>
                            <input type="text" class="form-control" id="telefono" name="telefono" required>
                        </div>
                        <div class="mb-3">
                            <label for="id_rol" class="form-label">Rol</label>
                            <select class="form-select" id="id_rol" name="id_rol" required>
                                <?php
                                $roles = $con->query("SELECT * FROM roles")->fetchAll(PDO::FETCH_ASSOC);
                                foreach ($roles as $rol) {
                                    echo "<option value='{$rol['id_rol']}'>{$rol['tip_rol']}</option>";
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
                                    echo "<option value='{$estado['id_estado']}'>{$estado['tipo_stade']}</option>";
                                }
                                ?>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Guardar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>