<?php
// Iniciar sesión si no está activa
if (session_status() !== PHP_SESSION_ACTIVE) {
    session_start();
}

require_once('../../conecct/conex.php'); // Ajusta a 'connect' si es correcto
require_once('../../includes/validarsession.php');

ini_set('display_errors', 0);
ini_set('log_errors', 1);
ini_set('error_log', 'php_errors.log');

// Manejar solo solicitudes POST como API
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    header('Content-Type: application/json');
    $db = new Database();
    $con = $db->conectar();

    $response = ['success' => false, 'error' => ''];

    if (!$con) {
        error_log("Failed to connect to database in agregar_vehiculo.php");
        $response['error'] = 'No se pudo conectar a la base de datos';
        echo json_encode($response);
        exit;
    }

    $documento = $_SESSION['documento'] ?? null;
    if (!$documento) {
        $response['error'] = 'Sesión no válida. Por favor, inicia sesión.';
        echo json_encode($response);
        exit;
    }

    try {
        // Depuración: Verificar datos recibidos
        error_log("Datos recibidos: " . print_r($_POST, true) . print_r($_FILES, true));

        $placa = strtoupper(trim($_POST['placa'] ?? ''));
        $tipo_vehiculo = $_POST['tipo_vehiculo'] ?? null;
        $documento_usuario = $_POST['documento_usuario'] ?? null;
        $id_marca = $_POST['marca'] ?? null;
        $modelo = $_POST['modelo'] ?? null;
        $kilometraje_actual = $_POST['kilometraje_actual'] ?? null;
        $id_estado = $_POST['estado'] ?? null;
        $fecha_registro = date('Y-m-d');
        $foto_vehiculo = $_FILES['foto_vehiculo']['name'] ?? 'sin_foto_carro.png';

        // Validaciones
        if (!$placa || !$tipo_vehiculo || !$documento_usuario || !$id_marca || !$modelo || !$kilometraje_actual || !$id_estado) {
            $response['error'] = 'Todos los campos son obligatorios.';
            echo json_encode($response);
            exit;
        }

        $check_placa = $con->prepare("SELECT placa FROM vehiculos WHERE placa = :placa");
        $check_placa->bindParam(':placa', $placa, PDO::PARAM_STR);
        $check_placa->execute();
        if ($check_placa->rowCount() > 0) {
            $response['error'] = 'La placa ya está registrada.';
            echo json_encode($response);
            exit;
        }

        if ($_FILES['foto_vehiculo']['name']) {
            $target_dir = "../../../roles/usuario/vehiculos/listar/guardar_foto_vehiculo/";
            if (!is_dir($target_dir)) {
                mkdir($target_dir, 0755, true);
            }
            $target_file = $target_dir . basename($_FILES['foto_vehiculo']['name']);
            if (!move_uploaded_file($_FILES['foto_vehiculo']['tmp_name'], $target_file)) {
                $response['error'] = 'Error al subir la foto del vehículo.';
                echo json_encode($response);
                exit;
            }
        }

        $insert = $con->prepare("INSERT INTO vehiculos (placa, tipo_vehiculo, Documento, id_marca, modelo, kilometraje_actual, id_estado, fecha_registro, foto_vehiculo) 
                                VALUES (:placa, :tipo_vehiculo, :documento, :id_marca, :modelo, :kilometraje_actual, :id_estado, :fecha_registro, :foto_vehiculo)");
        $insert->bindParam(':placa', $placa, PDO::PARAM_STR);
        $insert->bindParam(':tipo_vehiculo', $tipo_vehiculo, PDO::PARAM_INT);
        $insert->bindParam(':documento', $documento_usuario, PDO::PARAM_STR);
        $insert->bindParam(':id_marca', $id_marca, PDO::PARAM_INT);
        $insert->bindParam(':modelo', $modelo, PDO::PARAM_STR);
        $insert->bindParam(':kilometraje_actual', $kilometraje_actual, PDO::PARAM_INT);
        $insert->bindParam(':id_estado', $id_estado, PDO::PARAM_INT);
        $insert->bindParam(':fecha_registro', $fecha_registro, PDO::PARAM_STR);
        $insert->bindParam(':foto_vehiculo', $foto_vehiculo, PDO::PARAM_STR);

        if ($insert->execute()) {
            $response['success'] = true;
            $response['message'] = 'Vehículo agregado exitosamente.';
        } else {
            $response['error'] = 'Error al registrar el vehículo: ' . implode(', ', $insert->errorInfo());
        }
    } catch (PDOException $e) {
        error_log("Database error in agregar_vehiculo.php: " . $e->getMessage());
        $response['error'] = 'Error en la base de datos: ' . $e->getMessage();
    } catch (Exception $e) {
        error_log("General error in agregar_vehiculo.php: " . $e->getMessage());
        $response['error'] = 'Error inesperado: ' . $e->getMessage();
    }

    echo json_encode($response);
    exit;
}

// Renderizar HTML solo si es una solicitud GET (carga inicial)
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $db = new Database();
    $con = $db->conectar();
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Vehículo - Flotax AGC</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/vehiculos-modal.css">
</head>
<body>
<div class="modal fade" id="modalAgregarVehiculo" tabindex="-1" aria-labelledby="modalAgregarVehiculoLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalAgregarVehiculoLabel">Agregar Nuevo Vehículo</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="agregarVehiculoForm" method="POST" enctype="multipart/form-data" action="">
                    <div class="mb-3">
                        <label for="placa" class="form-label">Placa</label>
                        <input type="text" class="form-control" id="placa" name="placa" required maxlength="10">
                    </div>
                    <div class="mb-3">
                        <label for="documento_usuario" class="form-label">Usuario</label>
                        <select class="form-select" id="documento_usuario" name="documento_usuario" required>
                            <?php if ($con): ?>
                                <?php $usuarios = $con->query("SELECT documento, nombre_completo FROM usuarios"); ?>
                                <?php while ($usuario = $usuarios->fetch(PDO::FETCH_ASSOC)): ?>
                                    <option value="<?php echo htmlspecialchars($usuario['documento']); ?>">
                                        <?php echo htmlspecialchars($usuario['nombre_completo']) . ' (' . htmlspecialchars($usuario['documento']) . ')'; ?>
                                    </option>
                                <?php endwhile; ?>
                            <?php else: ?>
                                <option value="">Error de conexión</option>
                            <?php endif; ?>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="tipo_vehiculo" class="form-label">Tipo de Vehículo</label>
                        <select class="form-select" id="tipo_vehiculo" name="tipo_vehiculo" required>
                            <?php if ($con): ?>
                                <?php $tipos = $con->query("SELECT id_tipo_vehiculo, vehiculo FROM tipo_vehiculo"); ?>
                                <?php while ($tipo = $tipos->fetch(PDO::FETCH_ASSOC)): ?>
                                    <option value="<?php echo htmlspecialchars($tipo['id_tipo_vehiculo']); ?>">
                                        <?php echo htmlspecialchars($tipo['vehiculo']); ?>
                                    </option>
                                <?php endwhile; ?>
                            <?php else: ?>
                                <option value="">Error de conexión</option>
                            <?php endif; ?>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="marca" class="form-label">Marca</label>
                        <select class="form-select" id="marca" name="marca" required>
                            <?php if ($con): ?>
                                <?php $marcas = $con->query("SELECT id_marca, nombre_marca FROM marca"); ?>
                                <?php while ($marca = $marcas->fetch(PDO::FETCH_ASSOC)): ?>
                                    <option value="<?php echo htmlspecialchars($marca['id_marca']); ?>">
                                        <?php echo htmlspecialchars($marca['nombre_marca']); ?>
                                    </option>
                                <?php endwhile; ?>
                            <?php else: ?>
                                <option value="">Error de conexión</option>
                            <?php endif; ?>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="modelo" class="form-label">Modelo</label>
                        <input type="text" class="form-control" id="modelo" name="modelo" required>
                    </div>
                    <div class="mb-3">
                        <label for="kilometraje_actual" class="form-label">Kilometraje Actual</label>
                        <input type="number" class="form-control" id="kilometraje_actual" name="kilometraje_actual" required>
                    </div>
                    <div class="mb-3">
                        <label for="estado" class="form-label">Estado</label>
                        <select class="form-select" id="estado" name="estado" required>
                            <?php if ($con): ?>
                                <?php $estados = $con->query("SELECT id_estado, estado FROM estado_vehiculo"); ?>
                                <?php while ($estado = $estados->fetch(PDO::FETCH_ASSOC)): ?>
                                    <option value="<?php echo htmlspecialchars($estado['id_estado']); ?>">
                                        <?php echo htmlspecialchars($estado['estado']); ?>
                                    </option>
                                <?php endwhile; ?>
                            <?php else: ?>
                                <option value="">Error de conexión</option>
                            <?php endif; ?>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="foto_vehiculo" class="form-label">Foto del Vehículo</label>
                        <input type="file" class="form-control" id="foto_vehiculo" name="foto_vehiculo" accept="image/*">
                        <img id="foto_vehiculo_preview" src="" alt="Vista previa" style="display:none; max-width:100%; margin-top:10px;">
                    </div>
                    <button type="submit" class="btn btn-primary">Guardar</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<?php
}
?>