<?php
// Inicia la sesión y verifica el acceso del usuario
session_start();
require_once('../../conecct/conex.php');
include '../../includes/validarsession.php';
$db = new Database();
$con = $db->conectar();

// Verificación de inicio de sesión
$documento = $_SESSION['documento'] ?? null;
if (!$documento) {
    header('Location: ../../login.php');
    exit;
}

// Obtiene nombre completo y foto de perfil si no están en sesión
$nombre_completo = $_SESSION['nombre_completo'] ?? null;
$foto_perfil = $_SESSION['foto_perfil'] ?? null;
if (!$nombre_completo || !$foto_perfil) {
    $user_query = $con->prepare("SELECT nombre_completo, foto_perfil FROM usuarios WHERE documento = :documento");
    $user_query->bindParam(':documento', $documento, PDO::PARAM_STR);
    $user_query->execute();
    $user = $user_query->fetch(PDO::FETCH_ASSOC);
    $nombre_completo = $user['nombre_completo'] ?? 'Usuario';
    $foto_perfil = $user['foto_perfil'] ?: '/roles/usuario/css/img/perfil.jpg';
    $_SESSION['nombre_completo'] = $nombre_completo;
    $_SESSION['foto_perfil'] = $foto_perfil;
}

?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Flotax AGC - Inicio</title>
    <!-- Favicon y estilos principales -->
    <link rel="shortcut icon" href="css/img/logo_sinfondo.png">
    <link rel="stylesheet" href="css/styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    <!-- FullCalendar CSS y JS -->
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.css' rel='stylesheet' />
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
    <style>
  .evento-personalizado {
  background-color: #198754 !important; /* Verde Bootstrap */
  color: white !important;
  border-radius: 6px;
  padding: 2px 4px;
  font-weight: 500;
  font-size: 12px;
  line-height: 1.1;
  height: auto;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
}

</style>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>



</head>
<body>

<?php
    // Incluye el header del usuario
    include('header.php');
?>

<!-- Notificaciones de éxito o error -->
<?php if (isset($_SESSION['success']) || isset($_SESSION['error'])): ?>
<div class="notification">
    <?php if (isset($_SESSION['success'])): ?>
        <div class="alert success"><?php echo htmlspecialchars($_SESSION['success']); ?></div>
        <?php unset($_SESSION['success']); ?>
    <?php elseif (isset($_SESSION['error'])): ?>
        <div class="alert error"><?php echo htmlspecialchars($_SESSION['error']); ?></div>
        <?php unset($_SESSION['error']); ?>
    <?php endif; ?>
</div>
<?php endif; ?>

<!-- Sección de accesos rápidos a alertas de documentos y mantenimientos -->
<div class="alertas">
    <h1>Mis Alertas</h1>
    <div class="alertas-grid">
        <a href="vehiculos/registrar_soat" class="boton">
            <i class="bi bi-shield-check"></i> SOAT
        </a>
        <a href="vehiculos/registrar_tecnomecanica" class="boton">
            <i class="bi bi-tools"></i> Tecnomecánica
        </a>
        <a href="vehiculos/registrar_licencia" class="boton">
            <i class="bi bi-card-heading"></i> Licencia de Conducción
        </a>
        <a href="vehiculos/pico_placa" class="boton">
            <i class="bi bi-sign-stop"></i> Pico y Placa
        </a>
        <a href="vehiculos/registrar_llantas" class="boton">
            <i class="bi bi-circle"></i> Llantas
        </a>
        <a href="vehiculos/registrar_mantenimiento" class="boton">
            <i class="bi bi-gear"></i> Mantenimiento y Aceite
        </a>
        <a href="vehiculos/multas" class="boton">
            <i class="bi bi-receipt-cutoff"></i> Multas
        </a>
    </div>
</div>

<!-- Sección de selección y visualización de vehículos del usuario -->
<div class="garage">
    <div class="garage-content">
        <h2>Mis Vehículos</h2>
        <form action="vehiculos/listar/listar" method="get">
            <div class="form-group">
                <select name="vehiculo">
                    <option value="">Seleccionar Vehículo</option>
                    <?php
                    $vehiculos_query = $con->prepare("SELECT placa FROM vehiculos WHERE Documento = :documento");
                    $vehiculos_query->bindParam(':documento', $documento, PDO::PARAM_STR);
                    $vehiculos_query->execute();
                    $vehiculos = $vehiculos_query->fetchAll(PDO::FETCH_ASSOC);
                    foreach ($vehiculos as $vehiculo) {
                        echo '<option value="' . htmlspecialchars($vehiculo['placa']) . '">' . htmlspecialchars($vehiculo['placa']) . '</option>';
                    }
                    ?>
                </select>
                <button type="submit">Mostrar</button>
            </div>
        </form>
    </div>
</div>
<div class="calendario-usuario">
    <h2>Mi calendario</h2>
    <div id="calendario"></div>
</div>


<!-- Botón de cierre de sesión -->
<div class="sidebar">
    <a href="../../includes/salir" class="logout" title="Cerrar Sesión">
        <i class="bi bi-box-arrow-right"></i>
    </a>
</div>

<?php
    // Incluye el modal de cierre de sesión automático
    include('../../includes/auto_logout_modal.php');
?>

<script>
document.addEventListener('DOMContentLoaded', function () {
  var calendarEl = document.getElementById('calendario');
  var calendar = new FullCalendar.Calendar(calendarEl, {
    initialView: 'dayGridMonth',
    locale: 'es',
    events: 'calendario/cargar_eventos.php', // archivo PHP que devolverá los eventos en formato JSON
   eventClick: function(info) {
  const titulo = info.event.title;
  const descripcion = info.event.extendedProps.descripcion;
  const fecha = info.event.startStr;

  const detalles = descripcion
    .split('.')
    .map(texto => texto.trim())
    .filter(texto => texto !== '')
    .map(texto => `<li><i class="bi bi-dot"></i> ${texto}</li>`)
    .join('');

  document.querySelector('#eventoTitulo span').textContent = titulo;
  document.getElementById('eventoDescripcion').innerHTML = detalles;
  document.querySelector('#eventoFecha span').textContent = fecha;

  const myModal = new bootstrap.Modal(document.getElementById('eventoModal'));
  myModal.show();
}





  });
  calendar.render();
});

</script>

<div class="modal fade" id="eventoModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content shadow rounded-4 border-0" style="max-width: 500px; margin: auto;">
      <div class="modal-header bg-success text-white rounded-top-4">
        <h5 class="modal-title w-100 text-center m-0">
          <i class="bi bi-calendar-event-fill me-2"></i>Detalles del Evento
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
      </div>
      <div class="modal-body px-4 py-3 text-dark">
        <h6 id="eventoTitulo" class="fw-bold text-success text-center mb-3">
          <i class="bi bi-wrench-adjustable-circle me-1"></i><span></span>
        </h6>
        <ul id="eventoDescripcion" class="list-group list-group-flush mb-3">
          <!-- Lista de descripción -->
        </ul>
        <p id="eventoFecha" class="text-muted text-center mb-0">
          <i class="bi bi-clock-history me-2"></i><span></span>
        </p>
      </div>
      <div class="modal-footer border-0 justify-content-center pb-4">
        <button type="button" class="btn btn-outline-success rounded-pill px-4" data-bs-dismiss="modal">
          <i class="bi bi-x-circle me-1"></i> Cerrar
        </button>
      </div>
    </div>
  </div>
</div>



<style>
<style>
/* Estilo para el modal centrado y elegante */
.modal-content {
  border-radius: 1rem;
  box-shadow: 0 8px 30px rgba(0, 0, 0, 0.2);
}

.modal-header {
  border-bottom: none;
  padding-top: 1rem;
  padding-bottom: 1rem;
}

.modal-header .modal-title {
  font-size: 1.25rem;
  font-weight: bold;
}

.modal-body h6 {
  font-size: 1.1rem;
  color: #198754;
}

#eventoDescripcion li {
  margin-bottom: 0.5rem;
  font-size: 0.95rem;
  color: #495057;
  list-style: none;
  padding-left: 1rem;
  position: relative;
}

#eventoDescripcion li::before {
  content: "•";
  color: #198754;
  position: absolute;
  left: 0;
  font-weight: bold;
}

.modal-footer {
  border-top: none;
}

.modal-footer .btn {
  padding: 0.5rem 1.5rem;
  font-weight: 600;
  font-size: 0.95rem;
}
</style>
<style>
.modal.fade .modal-dialog {
  transform: translateY(10%) !important;
  transition: transform 0.3s ease-out;
}
</style>
<style>
.calendario-usuario {
  max-width: 700px; /* Puedes cambiar a 800px, 700px, etc. */
  margin: 0 auto;   /* Centra horizontalmente */
  padding: 20px;
}

#calendario {
  max-width: 100%; /* Asegura que no desborde */
  margin: 0 auto;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
  border-radius: 10px;
}
</style>





</body>
</html>