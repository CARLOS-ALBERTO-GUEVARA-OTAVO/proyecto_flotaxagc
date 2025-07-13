<?php
session_start();
require_once('../../../conecct/conex.php');
require_once('../../../includes/validarsession.php');
$db = new Database();
$con = $db->conectar();

$documento = $_SESSION['documento'] ?? null;
if (!$documento) {
    header('Location: ../../../login/login.php');
    exit;
}

// Fetch nombre_completo and foto_perfil if not in session
$nombre_completo = $_SESSION['nombre_completo'] ?? null;
$foto_perfil = $_SESSION['foto_perfil'] ?? null;
if (!$nombre_completo || !$foto_perfil) {
    $user_query = $con->prepare("SELECT nombre_completo, foto_perfil FROM usuarios WHERE documento = :documento");
    $user_query->bindParam(':documento', $documento, PDO::PARAM_STR);
    $user_query->execute();
    $user = $user_query->fetch(PDO::FETCH_ASSOC);
    $nombre_completo = $user['nombre_completo'] ?? 'Usuario';
    $foto_perfil = $user['foto_perfil'] ?: '/proyecto/roles/usuario/css/img/perfil.jpg';
    $_SESSION['nombre_completo'] = $nombre_completo;
    $_SESSION['foto_perfil'] = $foto_perfil;
}

// Filtro por placa
$filtro_placa = $_GET['placa'] ?? '';

// Consulta de mantenimientos solo para los vehículos del usuario logueado y filtro por placa
if (!empty($filtro_placa)) {
    $mantenimientos_query = $con->prepare("
        SELECT m.*, v.placa, tm.descripcion AS tipo_mantenimiento,
               GROUP_CONCAT(CONCAT(c.Trabajo, ': $', d.subtotal) SEPARATOR ', ') AS detalles_trabajos
        FROM mantenimiento m
        JOIN vehiculos v ON m.placa = v.placa
        JOIN tipo_mantenimiento tm ON m.id_tipo_mantenimiento = tm.id_tipo_mantenimiento
        LEFT JOIN detalles_mantenimiento_clasificacion d ON m.id_mantenimiento = d.id_mantenimiento
        LEFT JOIN clasificacion_trabajo c ON d.id_trabajo = c.id
        WHERE v.Documento = :documento
        AND v.placa LIKE :placa
        GROUP BY m.id_mantenimiento
        ORDER BY m.fecha_programada DESC
    ");
    $mantenimientos_query->execute([
        'documento' => $documento,
        'placa' => "%$filtro_placa%"
    ]);
} else {
    $mantenimientos_query = $con->prepare("
        SELECT m.*, v.placa, tm.descripcion AS tipo_mantenimiento,
               GROUP_CONCAT(CONCAT(c.Trabajo, ': $', d.subtotal) SEPARATOR ', ') AS detalles_trabajos
        FROM mantenimiento m
        JOIN vehiculos v ON m.placa = v.placa
        JOIN tipo_mantenimiento tm ON m.id_tipo_mantenimiento = tm.id_tipo_mantenimiento
        LEFT JOIN detalles_mantenimiento_clasificacion d ON m.id_mantenimiento = d.id_mantenimiento
        LEFT JOIN clasificacion_trabajo c ON d.id_trabajo = c.id
        WHERE v.Documento = :documento
        GROUP BY m.id_mantenimiento
        ORDER BY m.fecha_programada DESC
    ");
    $mantenimientos_query->execute(['documento' => $documento]);
}
$mantenimientos = $mantenimientos_query->fetchAll(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Flotax AGC - Mantenimiento General</title>
    <link rel="shortcut icon" href="../../../css/img/logo_sinfondo.png">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        * { font-family: 'Poppins', sans-serif; }

        body {
            background: #f0f2f5;
            padding-bottom: 60px;
        }

        .container {
            margin-top: 60px;
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-weight: 600;
            margin-bottom: 30px;
            text-align: center;
            color: #333;
        }

        .table thead {
            background-color: #0d6efd;
            color: white;
        }

        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }

        .badge {
            font-size: 0.9rem;
            padding: 6px 10px;
            border-radius: 12px;
        }

        .estado-vigente { background-color: rgb(100, 253, 184); color: #0f5132; }
        .estado-vencido { background-color: rgb(248, 102, 114); color: rgb(123, 0, 0); }
        .estado-pendiente { background-color: rgb(255, 204, 0); color: rgb(102, 60, 0); }

        .search-container {
            background: #e9ecef;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
        }

        .search-container input {
            border: 1px solid #ced4da;
            border-radius: 20px;
            padding: 8px 15px;
            font-size: 14px;
            width: 100%;
            transition: border-color 0.3s ease;
        }

        .search-container input:focus {
            outline: none;
            border-color: #0d6efd;
            box-shadow: 0 0 5px rgba(13, 110, 253, 0.5);
        }

        .no-data {
            text-align: center;
            padding: 40px 20px;
            color: #6c757d;
            font-size: 1rem;
        }

        .no-data i {
            font-size: 3rem;
            margin-bottom: 15px;
            opacity: 0.5;
        }

        @media screen and (max-width: 768px) {
            .container { padding: 15px; }
            table { font-size: 0.9rem; }
            h2 { font-size: 1.4rem; }
            .search-container { padding: 10px; }
        }
    </style>
</head>
<body>

<?php include('../header.php'); ?>

<div class="container">
    <h2><i class="fas fa-tools me-2"></i>Historial de Mantenimientos</h2>

    <!-- Campo de búsqueda por placa -->
    <div class="search-container">
        <div class="d-flex justify-content-center">
            <input type="text" id="filtroPlaca" class="form-control text-uppercase" placeholder="🔍 Buscar por placa del vehículo" value="<?= htmlspecialchars($filtro_placa) ?>" style="text-transform: uppercase;">
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-hover table-bordered align-middle">
            <thead>
                <tr>
                    <th><i class="fas fa-car me-2"></i>Placa</th>
                    <th><i class="fas fa-cogs me-2"></i>Tipo</th>
                    <th><i class="fas fa-calendar-alt me-2"></i>F. Programada</th>
                    <th><i class="fas fa-calendar-check me-2"></i>F. Realizada</th>
                    <th><i class="fas fa-tachometer-alt me-2"></i>Kilometraje</th>
                </tr>
            </thead>
            <tbody>
                <?php if(count($mantenimientos) > 0): ?>
                    <?php foreach ($mantenimientos as $mantenimiento): ?>
                        <tr>
                            <td><strong><?php echo htmlspecialchars($mantenimiento['placa']); ?></strong></td>
                            <td>
                                <?php
                                    $tipo = strtolower($mantenimiento['tipo_mantenimiento']);
                                    $clase = match ($tipo) {
                                        'correctivo' => 'estado-vencido',
                                        'preventivo' => 'estado-pendiente',
                                        default => 'bg-secondary text-white'
                                    };
                                ?>
                                <span class="badge <?= $clase ?>"><?= ucfirst($tipo); ?></span>
                            </td>
                            <td><?php echo htmlspecialchars($mantenimiento['fecha_programada']); ?></td>
                            <td>
                                <?php if($mantenimiento['fecha_realizada']): ?>
                                    <span class="badge estado-vigente"><?php echo htmlspecialchars($mantenimiento['fecha_realizada']); ?></span>
                                <?php else: ?>
                                    <span class="badge estado-vencido">No realizada</span>
                                <?php endif; ?>
                            </td>
                            <td><?php echo htmlspecialchars($mantenimiento['kilometraje_actual'] ?: 'N/A'); ?></td>
                        </tr>
                    <?php endforeach; ?>
                <?php else: ?>
                    <tr>
                        <td colspan="5" class="no-data">
                            <i class="fas fa-tools"></i><br>
                            No hay registros de mantenimiento disponibles
                        </td>
                    </tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>

<?php include('../../../includes/auto_logout_modal.php'); ?>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Búsqueda automática
    const input = document.getElementById('filtroPlaca');
    let timeout = null;

    input.addEventListener('input', () => {
        clearTimeout(timeout);
        timeout = setTimeout(() => {
            const placa = input.value.trim().toUpperCase();
            const params = new URLSearchParams(window.location.search);
            if (placa) {
                params.set('placa', placa);
            } else {
                params.delete('placa');
            }
            window.location.href = window.location.pathname + '?' + params.toString();
        }, 500);
    });
</script>
</body>
</html>