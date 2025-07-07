<?php
// Verifica si la variable de sesión 'documento' no está establecida (usuario no autenticado)
if (!isset($_SESSION['documento'])) {

    // Elimina la variable de sesión 'documento' por seguridad (aunque ya no existe)
    unset($_SESSION['documento']);
    // Elimina la variable de sesión 'tipo' que almacena el rol del usuario
    unset($_SESSION['tipo']);
    // Elimina la variable de sesión 'estado' que almacena el estado del usuario
    unset($_SESSION['estado']);
    // Limpia completamente el array de sesión, eliminando todas las variables
    $_SESSION = array();
    // Destruye la sesión actual del servidor
    session_destroy();
    // Fuerza la escritura y cierre de la sesión
    session_write_close();

    // Verifica si la constante BASE_URL ya está definida para evitar redefinición
    if (!defined('BASE_URL')) {
        // Detecta si el servidor es localhost (entorno de desarrollo)
        if (strpos($_SERVER['HTTP_HOST'], 'localhost') !== false) {
            // Define BASE_URL para entorno local (XAMPP)
            define('BASE_URL', '/Proyecto');
        } else {
            // Define BASE_URL para entorno de producción (hosting)
            define('BASE_URL', ''); // O '/subcarpeta' si tu proyecto está en una subcarpeta en el hosting
        }
    }

    // Muestra una alerta JavaScript informando que debe ingresar credenciales
    echo "<script>alert('INGRESE CREDENCIALES DE LOGIN');</script>";
    // Redirige automáticamente al usuario a la página de login usando JavaScript
    echo "<script>window.location = '" . BASE_URL . "/login/login';</script>";
    // Termina la ejecución del script para evitar que continúe procesando
    exit();
}
?>