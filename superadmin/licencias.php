<?php
// superadmin/licencias.php
session_start();

// Verifica que solo el superadministrador tenga acceso
if (!isset($_SESSION['tipo']) || $_SESSION['tipo'] != 3) {
    header("Location: ../index.php");
    exit();
}

require_once '../conecct/conex.php';

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

// Consulta para obtener el total de licencias
try {
    $sql_total = $con->query("SELECT COUNT(*) as total FROM sistema_licencias");
    $total_licencias = $sql_total->fetch(PDO::FETCH_ASSOC)['total'];
    $total_paginas = ceil($total_licencias / $por_pagina);

    // Consulta para obtener las licencias con JOIN a la tabla usuarios
    $sql = $con->query("
        SELECT ls.*, u.nombre_completo
        FROM sistema_licencias ls
        LEFT JOIN usuarios u ON ls.usuario_asignado = u.documento
        LIMIT $offset, $por_pagina
    ");
    $licencias = $sql->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("Error en la consulta: " . $e->getMessage());
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestionar Licencias del Sistema</title>
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
        <h2 class="mb-4">Gestión de Licencias del Sistema</h2>
        <a href="dashboard.php" class="btn btn-secondary mb-3">Volver al Panel</a>

        <!-- Botón para abrir el formulario de agregar licencia -->
        <button type="button" class="btn btn-primary mb-3" data-bs-toggle="modal" data-bs-target="#addLicenciaModal">
            Agregar Licencia
        </button>

        <!-- Tabla de licencias -->
        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Usuario Asignado</th>
                        <th>Tipo</th>
                        <th>Inicio</th>
                        <th>Vencimiento</th>
                        <th>Máx. Usuarios</th>
                        <th>Máx. Vehículos</th>
                        <th>Estado</th>
                        <th>Clave Licencia</th>
                        <th>Creado</th>
                        <th>Actualizado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($licencias as $lic): ?>
                        <tr>
                            <td><?= htmlspecialchars($lic['id']) ?></td>
                            <td><?= htmlspecialchars($lic['nombre_completo'] . " (" . $lic['usuario_asignado'] . ")") ?></td>
                            <td><?= htmlspecialchars($lic['tipo_licencia']) ?></td>
                            <td><?= htmlspecialchars($lic['fecha_inicio']) ?></td>
                            <td><?= htmlspecialchars($lic['fecha_vencimiento']) ?></td>
                            <td><?= htmlspecialchars($lic['max_usuarios']) ?></td>
                            <td><?= htmlspecialchars($lic['max_vehiculos']) ?></td>
                            <td><?= htmlspecialchars($lic['estado']) ?></td>
                            <td><?= htmlspecialchars($lic['clave_licencia'] ?? '') ?></td>
                            <td><?= htmlspecialchars($lic['fecha_creacion']) ?></td>
                            <td><?= htmlspecialchars($lic['fecha_actualizacion']) ?></td>
                            <td>
                                <a href="editar_licencia.php?id=<?= urlencode($lic['id']) ?>" class="btn btn-sm btn-warning">Editar</a>
                                <a href="eliminar_licencia.php?id=<?= urlencode($lic['id']) ?>" class="btn btn-sm btn-danger" onclick="return confirm('¿Estás seguro de eliminar esta licencia?')">Eliminar</a>
                                <?php if ($lic['estado'] === 'activa'): ?>
                                    <form method="POST" action="cambiar_estado_licencia.php" style="display: inline;">
                                        <input type="hidden" name="id_licencia" value="<?= $lic['id'] ?>">
                                        <input type="hidden" name="nuevo_estado" value="suspendida">
                                        <button type="submit" class="btn btn-sm btn-warning">Desactivar</button>
                                    </form>
                                <?php else: ?>
                                    <form method="POST" action="cambiar_estado_licencia.php" style="display: inline;">
                                        <input type="hidden" name="id_licencia" value="<?= $lic['id'] ?>">
                                        <input type="hidden" name="nuevo_estado" value="activa">
                                        <button type="submit" class="btn btn-sm btn-success">Activar</button>
                                    </form>
                                <?php endif; ?>
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

    <!-- Modal para agregar licencia -->
    <div class="modal fade" id="addLicenciaModal" tabindex="-1" aria-labelledby="addLicenciaModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addLicenciaModalLabel">Agregar Nueva Licencia</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="agregar_licencia.php" method="POST">
                        <div class="mb-3">
                            <label for="usuario_asignado" class="form-label">Usuario Asignado</label>
                            <select class="form-select" id="usuario_asignado" name="usuario_asignado" required>
                                <?php
                                $usuarios = $con->query("SELECT documento, nombre_completo FROM usuarios WHERE id_estado_usuario = 1")->fetchAll(PDO::FETCH_ASSOC);
                                foreach ($usuarios as $usuario) {
                                    echo "<option value='{$usuario['documento']}'>{$usuario['nombre_completo']} ({$usuario['documento']})</option>";
                                }
                                ?>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="tipo_licencia" class="form-label">Tipo de Licencia</label>
                            <select class="form-select" id="tipo_licencia" name="tipo_licencia" required>
                                <option value="basica">Básica</option>
                                <option value="profesional">Profesional</option>
                                <option value="empresarial">Empresarial</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="fecha_inicio" class="form-label">Fecha de Inicio</label>
                            <input type="date" class="form-control" id="fecha_inicio" name="fecha_inicio" required>
                        </div>
                        <div class="mb-3">
                            <label for="fecha_vencimiento" class="form-label">Fecha de Vencimiento</label>
                            <input type="date" class="form-control" id="fecha_vencimiento" name="fecha_vencimiento" required>
                        </div>
                        <div class="mb-3">
                            <label for="max_usuarios" class="form-label">Máximo de Usuarios</label>
                            <input type="number" class="form-control" id="max_usuarios" name="max_usuarios" min="1" value="10" required>
                        </div>
                        <div class="mb-3">
                            <label for="max_vehiculos" class="form-label">Máximo de Vehículos</label>
                            <input type="number" class="form-control" id="max_vehiculos" name="max_vehiculos" min="1" value="50" required>
                        </div>
                        <div class="mb-3">
                            <label for="estado" class="form-label">Estado</label>
                            <select class="form-select" id="estado" name="estado" required>
                                <option value="activa">Activa</option>
                                <option value="vencida">Vencida</option>
                                <option value="suspendida">Suspendida</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="clave_licencia" class="form-label">Clave de Licencia</label>
                            <input type="text" class="form-control" id="clave_licencia" name="clave_licencia">
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