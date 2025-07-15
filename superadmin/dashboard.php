<?php
// Iniciar sesión
session_start();

// Verificar si el usuario ha iniciado sesión y es superadmin
if (!isset($_SESSION['documento']) || $_SESSION['tipo'] != 3) {
    header('Location: ../login.php'); // Redirige al login si no es superadmin
    exit;
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel Superadministrador</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Puedes agregar Bootstrap si lo necesitas -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f2f2f2;
        }
        .dashboard {
            margin-top: 50px;
        }
        .card-title {
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="container dashboard">
    <h1 class="text-center">Bienvenido Superadministrador</h1>
    <div class="text-center mb-4">
        <p>Documento: <strong><?php echo $_SESSION['documento']; ?></strong></p>
    </div>

    <div class="row justify-content-center">
        <!-- Aquí puedes agregar tarjetas o secciones para administración -->
        <div class="col-md-4">
            <div class="card text-white bg-primary mb-3">
                <div class="card-header">Usuarios</div>
                <div class="card-body">
                    <h5 class="card-title">Gestionar Usuarios</h5>
                    <p class="card-text">Agregar, editar o eliminar usuarios registrados.</p>
                    <a href="usuarios.php" class="btn btn-light">Ir</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card text-white bg-success mb-3">
                <div class="card-header">Licencias</div>
                <div class="card-body">
                    <h5 class="card-title">Verificar Licencias</h5>
                    <p class="card-text">Revisar estado de licencias activas, vencidas o inactivas.</p>
                    <a href="licencias.php" class="btn btn-light">Ir</a>
                </div>
            </div>
        </div>

        <!-- Puedes seguir agregando módulos -->
    </div>

    <div class="text-center mt-5">
        <a href="../includes/logout.php" class="btn btn-danger">Cerrar sesión</a>
    </div>
</div>

</body>
</html>
