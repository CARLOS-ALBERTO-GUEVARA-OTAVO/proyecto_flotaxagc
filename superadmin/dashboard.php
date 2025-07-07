<?php
session_start();

// Verificar que el usuario esté autenticado como superadmin
if (!isset($_SESSION['superadmin_logged']) || $_SESSION['superadmin_logged'] !== true) {
    header('Location: login.php');
    exit;
}

$nombre_superadmin = $_SESSION['superadmin_nombre'] ?? 'Superadmin';
$documento_superadmin = $_SESSION['superadmin_documento'] ?? '';

// Incluir conexión a la base de datos para obtener estadísticas
require_once '../conecct/conex.php';

// Crear instancia de la base de datos
$database = new Database();
$conexion = $database->conectar();

// Obtener estadísticas del sistema
try {
    // Total de vehículos
    $stmt = $conexion->prepare("SELECT COUNT(*) as total FROM vehiculos");
    $stmt->execute();
    $total_vehiculos = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
    
    // Total de usuarios
    $stmt = $conexion->prepare("SELECT COUNT(*) as total FROM usuarios");
    $stmt->execute();
    $total_usuarios = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
    
    // Vehículos por estado
    $stmt = $conexion->prepare("SELECT ev.estado, COUNT(*) as cantidad FROM vehiculos v LEFT JOIN estado_vehiculo ev ON v.id_estado = ev.id_estado GROUP BY v.id_estado, ev.estado");
    $stmt->execute();
    $vehiculos_por_estado = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Mantenimientos pendientes (próximos 30 días)
    $stmt = $conexion->prepare("SELECT COUNT(*) as total FROM mantenimiento WHERE fecha_programada BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY) AND estado = 'Pendiente'");
    $stmt->execute();
    $mantenimientos_pendientes = $stmt->fetch(PDO::FETCH_ASSOC)['total'];
    
    // Últimos usuarios registrados
    $stmt = $conexion->prepare("SELECT u.nombre, u.apellido, u.documento, u.fecha_registro, r.tip_rol FROM usuarios u LEFT JOIN roles r ON u.id_rol = r.id_rol ORDER BY u.fecha_registro DESC LIMIT 5");
    $stmt->execute();
    $ultimos_usuarios = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
} catch (Exception $e) {
    $total_vehiculos = 0;
    $total_usuarios = 0;
    $vehiculos_por_estado = [];
    $mantenimientos_pendientes = 0;
    $ultimos_usuarios = [];
    error_log("Error en dashboard: " . $e->getMessage());
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Superadmin - Sistema de Gestión de Flota</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- Eliminar la línea 64 que incluye Chart.js CSS -->
    <!-- <link href="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.css" rel="stylesheet"> -->
    <style>
    :root {
        --primary-color: #1a3c34; /* Deep teal for a professional look */
        --secondary-color: #00a896; /* Vibrant teal accent */
        --accent-color: #f4a261; /* Warm orange for highlights */
        --background-color: #f0f4f8; /* Light, clean background */
        --card-background: #ffffff; /* White for cards */
        --text-color: #2d3436; /* Dark gray for text */
        --muted-text: #636e72; /* Muted gray for secondary text */
        --danger-color: #d63031; /* Red for danger/logout */
    }

    body {
        background-color: var(--background-color);
        font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
        color: var(--text-color);
        margin: 0;
        line-height: 1.6;
    }

    .sidebar {
        background: linear-gradient(180deg, var(--primary-color), #0d2a25);
        min-height: 100vh;
        padding-top: 20px;
        transition: all 0.3s ease;
        position: sticky;
        top: 0;
    }

    .sidebar .nav-link {
        color: #dfe6e9;
        padding: 12px 15px;
        margin: 8px 10px;
        border-radius: 10px;
        display: flex;
        align-items: center;
        font-weight: 500;
        transition: all 0.3s ease;
    }

    .sidebar .nav-link:hover {
        background-color: rgba(255, 255, 255, 0.15);
        color: #ffffff;
        transform: translateX(4px);
    }

    .sidebar .nav-link.active {
        background-color: var(--secondary-color);
        color: #ffffff;
        box-shadow: 0 2px 8px rgba(0, 168, 150, 0.3);
    }

    .sidebar .nav-link i {
        margin-right: 10px;
        font-size: 1.2rem;
    }

    .main-content {
        padding: 30px;
    }

    .stat-card {
        background: var(--card-background);
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
        border-left: 5px solid var(--secondary-color);
        position: relative;
        overflow: hidden;
    }

    .stat-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
    }

    .stat-card.primary { border-left-color: var(--primary-color); }
    .stat-card.success { border-left-color: var(--secondary-color); }
    .stat-card.warning { border-left-color: var(--accent-color); }
    .stat-card.danger { border-left-color: var(--danger-color); }

    .stat-icon {
        font-size: 2.2rem;
        opacity: 0.9;
        color: var(--secondary-color);
    }

    .stat-card h3 {
        font-size: 1.8rem;
        font-weight: 700;
        margin-bottom: 5px;
        color: var(--text-color);
    }

    .stat-card p {
        font-size: 0.9rem;
        color: var(--muted-text);
        margin: 0;
    }

    .table-container {
        background: var(--card-background);
        border-radius: 12px;
        padding: 20px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        margin-top: 30px;
    }

    .table-container h5 {
        font-weight: 600;
        color: var(--text-color);
        margin-bottom: 20px;
    }

    .table th {
        font-weight: 600;
        color: var(--text-color);
        background-color: #f8f9fa;
    }

    .table td {
        vertical-align: middle;
        color: var(--text-color);
    }

    .table .badge {
        padding: 6px 12px;
        font-size: 0.85rem;
        border-radius: 20px;
    }

    .navbar-brand {
        font-weight: 700;
        color: var(--primary-color) !important;
        font-size: 1.4rem;
    }

    .user-info {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 12px;
        padding: 20px;
        margin: 20px 15px;
        text-align: center;
        color: #ffffff;
    }

    .user-avatar {
        width: 70px;
        height: 70px;
        border-radius: 50%;
        background: var(--secondary-color);
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 12px;
        font-size: 1.8rem;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
    }

    .user-info h6 {
        font-weight: 600;
        margin-bottom: 5px;
    }

    .user-info small {
        font-size: 0.85rem;
        color: rgba(255, 255, 255, 0.7);
    }

    .dropdown-menu {
        border-radius: 10px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        border: none;
    }

    .dropdown-item {
        padding: 10px 20px;
        font-weight: 500;
        color: var(--text-color);
    }

    .dropdown-item:hover {
        background-color: var(--background-color);
        color: var(--primary-color);
    }

    .dropdown-item.text-danger {
        color: var(--danger-color) !important;
    }

    hr.text-white-50 {
        border-color: rgba(255, 255, 255, 0.2);
    }

    @media (max-width: 768px) {
        .sidebar {
            position: fixed;
            width: 250px;
            z-index: 1000;
        }
        .main-content {
            padding: 20px;
        }
        .stat-card {
            padding: 15px;
        }
        .stat-icon {
            font-size: 2rem;
        }
    }
</style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 px-0 sidebar">
                <div class="user-info">
                    <div class="user-avatar">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <h6 class="text-white mb-1"><?php echo htmlspecialchars($nombre_superadmin); ?></h6>
                    <small class="text-white-50">Superadministrador</small>
                </div>
                
                <nav class="nav flex-column">
                    <a class="nav-link active" href="dashboard.php">
                        <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                    </a>
                    <a class="nav-link" href="licenciamiento.php">
                        <i class="fas fa-certificate me-2"></i> Licenciamiento
                    </a>
                    <hr class="text-white-50">
                    <a class="nav-link text-danger" href="logout.php">
                        <i class="fas fa-sign-out-alt me-2"></i> Cerrar Sesión
                    </a>
                </nav>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3 mb-0">Panel de Control Superadmin</h1>
                    <div class="d-flex align-items-center">
                        <span class="me-3">Último acceso: <?php echo date('d/m/Y H:i'); ?></span>
                        <div class="dropdown">
                            <button class="btn btn-outline-primary dropdown-toggle" type="button" data-bs-toggle="dropdown">
                                <i class="fas fa-user-shield me-2"></i><?php echo htmlspecialchars($nombre_superadmin); ?>
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#"><i class="fas fa-user me-2"></i>Perfil</a></li>
                                <li><a class="dropdown-item" href="#"><i class="fas fa-cog me-2"></i>Configuración</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger" href="logout.php"><i class="fas fa-sign-out-alt me-2"></i>Cerrar Sesión</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                
                <!-- Dashboard Section -->
                <div id="dashboard-section" class="content-section">
                    <!-- Statistics Cards -->
                    <div class="row mb-4">
                        <div class="col-md-3 mb-3">
                            <div class="stat-card primary">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h3 class="mb-1"><?php echo $total_vehiculos; ?></h3>
                                        <p class="text-muted mb-0">Total Vehículos</p>
                                    </div>
                                    <div class="stat-icon text-primary">
                                        <i class="fas fa-car"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="stat-card success">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h3 class="mb-1"><?php echo $total_usuarios; ?></h3>
                                        <p class="text-muted mb-0">Total Usuarios</p>
                                    </div>
                                    <div class="stat-icon text-success">
                                        <i class="fas fa-users"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="stat-card warning">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h3 class="mb-1"><?php echo $mantenimientos_pendientes; ?></h3>
                                        <p class="text-muted mb-0">Mantenimientos Pendientes</p>
                                    </div>
                                    <div class="stat-icon text-warning">
                                        <i class="fas fa-wrench"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 mb-3">
                            <div class="stat-card danger">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <h3 class="mb-1"><?php echo count($vehiculos_por_estado); ?></h3>
                                        <p class="text-muted mb-0">Estados Activos</p>
                                    </div>
                                    <div class="stat-icon text-danger">
                                        <i class="fas fa-chart-pie"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Charts and Tables Row -->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="table-container">
                                <h5 class="mb-3">Últimos Usuarios Registrados</h5>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="table-light">
                                            <tr>
                                                <th>Nombre</th>
                                                <th>Documento</th>
                                                <th>Rol</th>
                                                <th>Fecha</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php foreach ($ultimos_usuarios as $usuario): ?>
                                            <tr>
                                                <td><?php echo htmlspecialchars($usuario['nombre'] . ' ' . $usuario['apellido']); ?></td>
                                                <td><?php echo htmlspecialchars($usuario['documento']); ?></td>
                                                <td>
                                                    <span class="badge bg-<?php echo $usuario['tip_rol'] == 'Administrador' ? 'primary' : 'secondary'; ?>">
                                                        <?php echo htmlspecialchars($usuario['tip_rol']); ?>
                                                    </span>
                                                </td>
                                                <td><?php echo date('d/m/Y', strtotime($usuario['fecha_registro'])); ?></td>
                                            </tr>
                                            <?php endforeach; ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Eliminar la línea que incluye Chart.js -->
    <!-- <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> -->
    <script>
        // Función para mostrar secciones
        function showSection(sectionName) {
            // Ocultar todas las secciones
            const sections = document.querySelectorAll('.content-section');
            sections.forEach(section => {
                section.style.display = 'none';
            });
            
            // Mostrar la sección seleccionada
            document.getElementById(sectionName + '-section').style.display = 'block';
            
            // Actualizar navegación activa
            const navLinks = document.querySelectorAll('.nav-link');
            navLinks.forEach(link => {
                link.classList.remove('active');
            });
            event.target.classList.add('active');
        }
        
        // Auto-refresh cada 5 minutos
        setInterval(function() {
            location.reload();
        }, 300000);
    </script>
</body>
</html>