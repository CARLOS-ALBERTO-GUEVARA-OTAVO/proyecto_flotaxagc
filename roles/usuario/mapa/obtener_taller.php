<?php
require_once('../../../conecct/conex.php');
$db = new Database();
$con = $db->conectar();

// Solo talleres activos
$sql = $con->query("SELECT nombre, direccion, telefono, latitud, longitud FROM talleres WHERE estado = 'activo'");
$talleres = $sql->fetchAll(PDO::FETCH_ASSOC);
header('Content-Type: application/json');
echo json_encode($talleres);
?>
