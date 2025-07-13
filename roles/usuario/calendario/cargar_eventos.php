<?php
session_start();
require_once('../../../conecct/conex.php');

$db = new Database();
$con = $db->conectar();

$documento = $_SESSION['documento'] ?? null;
if (!$documento) {
    echo json_encode([]);
    exit;
}

$eventos = [];

// Fecha actual para filtrar eventos próximos a vencer
$fecha_actual = date('Y-m-d');
$fecha_limite = date('Y-m-d', strtotime('+30 days'));

// Eventos de SOAT
$sql1 = "SELECT 'SOAT vence' AS title, s.fecha_vencimiento AS start, 
         CONCAT('Aseguradora: ', a.nombre, '. Revisar seguro obligatorio') AS descripcion 
         FROM soat s 
         JOIN aseguradoras_soat a ON s.id_aseguradora = a.id_asegura 
         JOIN vehiculos v ON s.id_placa = v.placa 
         WHERE v.Documento = :documento 
         AND s.fecha_vencimiento BETWEEN :fecha_actual AND :fecha_limite";
$stmt1 = $con->prepare($sql1);
$stmt1->bindParam(':documento', $documento, PDO::PARAM_STR);
$stmt1->bindParam(':fecha_actual', $fecha_actual, PDO::PARAM_STR);
$stmt1->bindParam(':fecha_limite', $fecha_limite, PDO::PARAM_STR);
$stmt1->execute();
$eventos = array_merge($eventos, $stmt1->fetchAll(PDO::FETCH_ASSOC));

// Eventos de Tecnomecánica
$sql2 = "SELECT 'Tecnomecánica vence' AS title, t.fecha_vencimiento AS start, 
         CONCAT('Centro: ', c.centro_revision, '. Revisión técnica obligatoria') AS descripcion 
         FROM tecnomecanica t 
         JOIN centro_rtm c ON t.id_centro_revision = c.id_centro 
         JOIN vehiculos v ON t.id_placa = v.placa 
         WHERE v.Documento = :documento 
         AND t.fecha_vencimiento BETWEEN :fecha_actual AND :fecha_limite";
$stmt2 = $con->prepare($sql2);
$stmt2->bindParam(':documento', $documento, PDO::PARAM_STR);
$stmt2->bindParam(':fecha_actual', $fecha_actual, PDO::PARAM_STR);
$stmt2->bindParam(':fecha_limite', $fecha_limite, PDO::PARAM_STR);
$stmt2->execute();
$eventos = array_merge($eventos, $stmt2->fetchAll(PDO::FETCH_ASSOC));

// Eventos de Licencias de Conducción
$sql3 = "SELECT 'Licencia vence' AS title, l.fecha_vencimiento AS start, 
         CONCAT('Categoría: ', cat.nombre_categoria, '. Renueva a tiempo') AS descripcion 
         FROM licencias l 
         JOIN categoria_licencia cat ON l.id_categoria = cat.id_categoria 
         WHERE l.id_documento = :documento 
         AND l.fecha_vencimiento BETWEEN :fecha_actual AND :fecha_limite";
$stmt3 = $con->prepare($sql3);
$stmt3->bindParam(':documento', $documento, PDO::PARAM_STR);
$stmt3->bindParam(':fecha_actual', $fecha_actual, PDO::PARAM_STR);
$stmt3->bindParam(':fecha_limite', $fecha_limite, PDO::PARAM_STR);
$stmt3->execute();
$eventos = array_merge($eventos, $stmt3->fetchAll(PDO::FETCH_ASSOC));

// Eventos de Llantas
$sql4 = "SELECT 'Cambio de llantas' AS title, l.proximo_cambio_fecha AS start, 
         CONCAT('Placa: ', l.placa, '. Kilometraje próximo: ', l.proximo_cambio_km) AS descripcion 
         FROM llantas l 
         JOIN vehiculos v ON l.placa = v.placa 
         WHERE v.Documento = :documento 
         AND l.proximo_cambio_fecha BETWEEN :fecha_actual AND :fecha_limite";
$stmt4 = $con->prepare($sql4);
$stmt4->bindParam(':documento', $documento, PDO::PARAM_STR);
$stmt4->bindParam(':fecha_actual', $fecha_actual, PDO::PARAM_STR);
$stmt4->bindParam(':fecha_limite', $fecha_limite, PDO::PARAM_STR);
$stmt4->execute();
$eventos = array_merge($eventos, $stmt4->fetchAll(PDO::FETCH_ASSOC));

// Eventos de Mantenimiento
$sql5 = "SELECT 'Mantenimiento' AS title, m.proximo_cambio_fecha AS start, 
         CONCAT('Placa: ', m.placa, '. Tipo: ', tm.descripcion, '. Kilometraje próximo: ', m.proximo_cambio_km) AS descripcion 
         FROM mantenimiento m 
         JOIN tipo_mantenimiento tm ON m.id_tipo_mantenimiento = tm.id_tipo_mantenimiento 
         JOIN vehiculos v ON m.placa = v.placa 
         WHERE v.Documento = :documento 
         AND m.proximo_cambio_fecha BETWEEN :fecha_actual AND :fecha_limite";
$stmt5 = $con->prepare($sql5);
$stmt5->bindParam(':documento', $documento, PDO::PARAM_STR);
$stmt5->bindParam(':fecha_actual', $fecha_actual, PDO::PARAM_STR);
$stmt5->bindParam(':fecha_limite', $fecha_limite, PDO::PARAM_STR);
$stmt5->execute();
$eventos = array_merge($eventos, $stmt5->fetchAll(PDO::FETCH_ASSOC));

// Agregar clase personalizada a cada evento
foreach ($eventos as &$evento) {
    $evento['className'] = 'evento-personalizado';
}

echo json_encode($eventos);