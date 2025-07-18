-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 18-07-2025 a las 18:04:44
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyecto_flota`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `aseguradoras_soat`
--

CREATE TABLE `aseguradoras_soat` (
  `id_asegura` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `aseguradoras_soat`
--

INSERT INTO `aseguradoras_soat` (`id_asegura`, `nombre`) VALUES
(20, 'Aseguradora Solidaria de Colombia Ltda.'),
(21, 'AXA Colpatria Seguros S.A.'),
(22, 'La Equidad Seguros Generales'),
(23, 'Liberty Seguros S.A.'),
(24, 'La Previsora S.A. Compañía de Seguros'),
(25, 'Seguros Bolívar S.A.'),
(26, 'Seguros Mundial'),
(27, 'Seguros del Estado S.A.'),
(28, 'Seguros Generales Suramericana S.A.'),
(29, 'HDI Seguros Colombia S.A.'),
(30, 'Mapfre Seguros Generales de Colombia S.A.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria_licencia`
--

CREATE TABLE `categoria_licencia` (
  `id_categoria` int(11) NOT NULL,
  `nombre_categoria` text NOT NULL,
  `id_servicio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria_licencia`
--

INSERT INTO `categoria_licencia` (`id_categoria`, `nombre_categoria`, `id_servicio`) VALUES
(1, 'A1 - Motocicletas hasta 125cc', 1),
(2, 'A2 - Motocicletas mayores a 125cc y vehículos similares', 1),
(3, 'B1 - Automóviles, camperos, camionetas y vans de servicio particular', 1),
(4, 'B2 - Camiones rígidos, buses y busetas de servicio particular', 1),
(5, 'B3 - Vehículos articulados de servicio particular', 1),
(6, 'C1 - Automóviles, camperos, camionetas y vans de servicio público', 2),
(7, 'C2 - Camiones rígidos, buses y busetas de servicio público', 2),
(8, 'C3 - Vehículos articulados de servicio público', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centro_rtm`
--

CREATE TABLE `centro_rtm` (
  `id_centro` int(11) NOT NULL,
  `centro_revision` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `centro_rtm`
--

INSERT INTO `centro_rtm` (`id_centro`, `centro_revision`) VALUES
(1, 'DIAGNOSTICENTRO DEL NORTE MARIQUITA LTDA'),
(2, 'C.D.A. DIAGNOSTICAR'),
(3, 'IVESUR COLOMBIA - IBAGUE'),
(4, 'C.D.A. DIAGNOSTI-MOTOS ESPINAL'),
(5, 'CDA PEÑAS DEL RIO'),
(6, 'CDA MOTO CLUB AMBALA SAS'),
(7, 'CENTRO DE DIAGNOSTICO Y REVISIÓN DE VEHÍCULOS AUTOMOTORES “C'),
(8, 'CDA DEL TOLIMA'),
(9, 'CENTRO DE DIAGNOSTICO AUTOMOTRIZ TECNI MOTORS IBAGUE'),
(10, 'CENTRO DE DIAGNOSTICO AUTOMOTOR CDA BETANIA'),
(11, 'CENTRO DE DIAGNOSTICO AUTOMOTOR EL CARMEN S.A.S.'),
(12, 'CDA AUTOMOTOS DEL TOLIMA'),
(13, 'CDA MOTOS IBAGUE S.A.S'),
(14, 'CDA DEL CENTRO SAS'),
(15, 'CDA LA REVISION SAS'),
(16, 'CDA MOTOS DE LA SEXTA'),
(17, 'CENTRO DE DIAGNÓSTICO AUTOMOTRIZ DEL ESPINAL S.A.S.'),
(18, 'CDA REVIEXPRESS S.A.S'),
(19, 'CDA CEDITRANS S.A.'),
(20, 'CDA DIAGNOSTILISTO S.A.S.'),
(21, 'CDA DIAGNOSTI-CAR'),
(22, 'CDA TECNIMOTO AUTOS ESPINAL S.A.S');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clasificacion_trabajo`
--

CREATE TABLE `clasificacion_trabajo` (
  `id` int(11) NOT NULL,
  `Trabajo` varchar(255) NOT NULL,
  `Precio` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `clasificacion_trabajo`
--

INSERT INTO `clasificacion_trabajo` (`id`, `Trabajo`, `Precio`) VALUES
(1, 'Aceite 5W-30 4L', 120000),
(2, 'Cambio de pastillas de freno', 150000),
(3, 'Alineación y balanceo', 80000),
(4, 'Revisión de suspensión', 100000),
(5, 'Cambio de batería', 200000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `contacto`
--

CREATE TABLE `contacto` (
  `id_mensa` int(11) NOT NULL,
  `nom` text NOT NULL,
  `apellido` text NOT NULL,
  `email` varchar(100) NOT NULL,
  `mensaje` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `contacto`
--

INSERT INTO `contacto` (`id_mensa`, `nom`, `apellido`, `email`, `mensaje`) VALUES
(15, 'adrian', 'asasa', 'aasas@gmail.com', 'aaaaaaaaaa'),
(16, 'adrian', 'sadsa', 'sadsadas@gmail.com', 'asasasasasa'),
(24, 'Adrian', 'camargo', 'adriancamargo69@gmail.com', 'hola grupito'),
(25, 'Edwar', 'Gomez ', 'Edwar@gmail.com', 'Necesito una cuenta de administrador'),
(26, 'eder', 'moyano', 'edermoyano@gmail.com', 'necesito algo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `correos_enviados_licencia`
--

CREATE TABLE `correos_enviados_licencia` (
  `id_correos` int(11) NOT NULL,
  `id_licencia` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `tipo_recordatorio` varchar(20) NOT NULL,
  `fecha_envio` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `correos_enviados_llantas`
--

CREATE TABLE `correos_enviados_llantas` (
  `id_correo` int(11) NOT NULL,
  `id_llantas` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `tipo_recordatorio` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `correos_enviados_llantas`
--

INSERT INTO `correos_enviados_llantas` (`id_correo`, `id_llantas`, `email`, `tipo_recordatorio`) VALUES
(1, 1, 'instructor@gmail.com', '3_dias'),
(2, 4, 'federico@gmail.com', '3_dias');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `correos_enviados_mantenimiento`
--

CREATE TABLE `correos_enviados_mantenimiento` (
  `id_correo` int(11) NOT NULL,
  `id_mantenimiento` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `tipo_recordatorio` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `correos_enviados_mantenimiento`
--

INSERT INTO `correos_enviados_mantenimiento` (`id_correo`, `id_mantenimiento`, `email`, `tipo_recordatorio`) VALUES
(1, 4, 'adriancamargo69@gmail.com', '1_dia'),
(2, 5, 'adriancamargo69@gmail.com', '1_dia'),
(3, 4, 'adriancamargo69@gmail.com', 'hoy'),
(4, 5, 'adriancamargo69@gmail.com', 'hoy'),
(5, 6, 'federico@gmail.com', '3_dias');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `correos_enviados_pico_placa`
--

CREATE TABLE `correos_enviados_pico_placa` (
  `id_correos` int(11) NOT NULL,
  `placa` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `fecha_envio` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `correos_enviados_pico_placa`
--

INSERT INTO `correos_enviados_pico_placa` (`id_correos`, `placa`, `email`, `fecha_envio`) VALUES
(1, 'WQW222', 'milady@gmail.com', '2025-06-30'),
(2, 'KKK222', 'edwardfaridg@gmail.com', '2025-06-30'),
(3, 'AAS232', 'instructor@gmail.com', '2025-06-30'),
(4, 'ASD231', 'instructor@gmail.com', '2025-06-30'),
(5, 'DAS231', 'instructor@gmail.com', '2025-06-30'),
(6, 'POP321', 'Carlosgo1822@gmail.com', '2025-06-30'),
(7, 'KKK333', 'milady@gmail.com', '2025-07-01'),
(9, 'ASD213', 'instructor@gmail.com', '2025-07-01'),
(11, 'MAS297', 'edwardfaridg@gmail.com', '2025-07-03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `correos_enviados_soat`
--

CREATE TABLE `correos_enviados_soat` (
  `id_correos` int(11) NOT NULL,
  `id_soat` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `tipo_recordatorio` varchar(20) NOT NULL,
  `fecha_envio` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `correos_enviados_tecno`
--

CREATE TABLE `correos_enviados_tecno` (
  `id_correo` int(11) NOT NULL,
  `id_rtm` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `tipo_recordatorio` varchar(20) NOT NULL,
  `fecha_envio` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalles_mantenimiento_clasificacion`
--

CREATE TABLE `detalles_mantenimiento_clasificacion` (
  `id` int(11) NOT NULL,
  `id_mantenimiento` int(11) NOT NULL,
  `id_trabajo` int(11) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empresas`
--

CREATE TABLE `empresas` (
  `id_empresa` int(11) NOT NULL,
  `nombre_empresa` varchar(255) NOT NULL,
  `nit` varchar(20) NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado` enum('activa','inactiva') DEFAULT 'activa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empresas`
--

INSERT INTO `empresas` (`id_empresa`, `nombre_empresa`, `nit`, `direccion`, `telefono`, `email`, `fecha_registro`, `estado`) VALUES
(1, 'FlotaX AGC', '900123456-1', 'Calle Principal 123', '3001234567', 'admin@flotaxagc.com', '2025-07-05 15:00:41', 'activa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_soat`
--

CREATE TABLE `estado_soat` (
  `id_stado` int(11) NOT NULL,
  `soat_est` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado_soat`
--

INSERT INTO `estado_soat` (`id_stado`, `soat_est`) VALUES
(1, 'Vigente'),
(2, 'Vencido');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_usuario`
--

CREATE TABLE `estado_usuario` (
  `id_estado` int(11) NOT NULL,
  `tipo_stade` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado_usuario`
--

INSERT INTO `estado_usuario` (`id_estado`, `tipo_stade`) VALUES
(1, 'Activo'),
(2, 'Inactivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_vehiculo`
--

CREATE TABLE `estado_vehiculo` (
  `id_estado` varchar(50) NOT NULL,
  `estado` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado_vehiculo`
--

INSERT INTO `estado_vehiculo` (`id_estado`, `estado`) VALUES
('1', 'Activo'),
('10', 'En uso'),
('2', 'Inactivo'),
('3', 'Mantenimiento'),
('4', 'Revisión'),
('5', 'Retirado'),
('6', 'Accidentado'),
('7', 'Pendiente'),
('8', 'Disponible'),
('9', 'Bloqueado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `eventos`
--

CREATE TABLE `eventos` (
  `id` int(11) NOT NULL,
  `documento_usuario` varchar(20) DEFAULT NULL,
  `titulo_evento` varchar(255) NOT NULL,
  `fecha_evento` date NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `licencias`
--

CREATE TABLE `licencias` (
  `id_documento` varchar(20) NOT NULL,
  `id_licencia` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `fecha_expedicion` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `id_servicio` int(11) NOT NULL,
  `observaciones` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `licencias`
--

INSERT INTO `licencias` (`id_documento`, `id_licencia`, `id_categoria`, `fecha_expedicion`, `fecha_vencimiento`, `id_servicio`, `observaciones`) VALUES
('1109491416', 3, 3, '2025-06-15', '2025-06-25', 1, NULL),
('9876543210', 6, 4, '2025-06-11', '2035-06-11', 1, ''),
('9876543210', 7, 5, '2022-06-29', '2025-06-25', 1, ''),
('1110174530', 9, 5, '2022-07-11', '2025-07-05', 1, 'hola senor alex'),
('1109491416', 10, 3, '2024-07-17', '2034-07-17', 1, '');

--
-- Disparadores `licencias`
--
DELIMITER $$
CREATE TRIGGER `after_insert_licencia` AFTER INSERT ON `licencias` FOR EACH ROW BEGIN
  INSERT INTO licencia_log (
    documento_usuario,
    id_categoria,
    fecha_expedicion,
    fecha_vencimiento,
    id_servicio,
    observaciones
  ) VALUES (
    NEW.id_documento,
    NEW.id_categoria,
    NEW.fecha_expedicion,
    NEW.fecha_vencimiento,
    NEW.id_servicio,
    NEW.observaciones
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `licencias_sistema`
--

CREATE TABLE `licencias_sistema` (
  `id` int(11) NOT NULL,
  `documento_usuario` varchar(20) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `estado` enum('activa','inactiva','vencida') DEFAULT 'activa',
  `clave_licencia` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `licencias_sistema`
--

INSERT INTO `licencias_sistema` (`id`, `documento_usuario`, `tipo`, `fecha_inicio`, `fecha_fin`, `estado`, `clave_licencia`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, '1110174520', 'superadmin', '2025-07-15', '2026-07-15', 'activa', 'Carlosydamaris1822#', '2025-07-15 17:43:59', '2025-07-15 17:43:59');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `licencia_log`
--

CREATE TABLE `licencia_log` (
  `id_log` int(11) NOT NULL,
  `documento_usuario` varchar(20) DEFAULT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `fecha_expedicion` date DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `id_servicio` int(11) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `licencia_log`
--

INSERT INTO `licencia_log` (`id_log`, `documento_usuario`, `id_categoria`, `fecha_expedicion`, `fecha_vencimiento`, `id_servicio`, `observaciones`, `fecha_registro`) VALUES
(1, '1109491416', 3, '2024-07-17', '2034-07-17', 1, '', '2025-07-03 02:15:28');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llantas`
--

CREATE TABLE `llantas` (
  `id_llanta` int(11) NOT NULL,
  `placa` varchar(10) NOT NULL,
  `estado` varchar(50) NOT NULL,
  `ultimo_cambio` date DEFAULT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `presion_llantas` decimal(4,1) DEFAULT NULL,
  `kilometraje_actual` int(11) DEFAULT NULL,
  `proximo_cambio_km` int(11) DEFAULT NULL,
  `proximo_cambio_fecha` date DEFAULT NULL,
  `notas` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `llantas`
--

INSERT INTO `llantas` (`id_llanta`, `placa`, `estado`, `ultimo_cambio`, `fecha_registro`, `presion_llantas`, `kilometraje_actual`, `proximo_cambio_km`, `proximo_cambio_fecha`, `notas`) VALUES
(1, 'GAS900', 'Malo', '2025-06-11', '2025-06-11 13:14:33', 30.0, 12345, 1233, '2025-07-05', 'cambios'),
(2, 'KKK222', 'Bueno', '2025-06-15', '2025-06-15 14:22:23', 23.0, 234422, 33, '2030-11-15', 'Nuevas'),
(4, 'CAR333', 'Regular', '2024-06-13', '2025-07-02 00:41:44', 10.2, 654231, 6546, '2025-07-05', 'Depierta senor alex'),
(5, 'MOM202', 'Bueno', '2025-07-02', '2025-07-03 02:16:52', 30.0, 5000000, 50000, '2026-07-02', 'Nuevas');

--
-- Disparadores `llantas`
--
DELIMITER $$
CREATE TRIGGER `after_insert_llantas` AFTER INSERT ON `llantas` FOR EACH ROW BEGIN
  DECLARE doc_usuario VARCHAR(20);

  -- Buscar el documento del usuario relacionado con la placa
  SELECT Documento INTO doc_usuario
  FROM vehiculos
  WHERE placa = NEW.placa
  LIMIT 1;

  -- Insertar en la tabla de historial
  INSERT INTO llantas_log (
    documento_usuario,
    placa_vehiculo,
    estado_llantas,
    ultimo_cambio,
    presion_llantas,
    kilometraje_actual,
    proximo_cambio_km,
    proximo_cambio_fecha,
    notas
  ) VALUES (
    doc_usuario,
    NEW.placa,
    NEW.estado,
    NEW.ultimo_cambio,
    NEW.presion_llantas,
    NEW.kilometraje_actual,
    NEW.proximo_cambio_km,
    NEW.proximo_cambio_fecha,
    NEW.notas
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `llantas_log`
--

CREATE TABLE `llantas_log` (
  `id_log` int(11) NOT NULL,
  `documento_usuario` varchar(20) DEFAULT NULL,
  `placa_vehiculo` varchar(10) DEFAULT NULL,
  `estado_llantas` varchar(20) DEFAULT NULL,
  `ultimo_cambio` date DEFAULT NULL,
  `presion_llantas` decimal(5,2) DEFAULT NULL,
  `kilometraje_actual` int(11) DEFAULT NULL,
  `proximo_cambio_km` int(11) DEFAULT NULL,
  `proximo_cambio_fecha` date DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `llantas_log`
--

INSERT INTO `llantas_log` (`id_log`, `documento_usuario`, `placa_vehiculo`, `estado_llantas`, `ultimo_cambio`, `presion_llantas`, `kilometraje_actual`, `proximo_cambio_km`, `proximo_cambio_fecha`, `notas`, `fecha_registro`) VALUES
(1, '1109491416', 'MOM202', 'Bueno', '2025-07-02', 30.00, 5000000, 50000, '2026-07-02', 'Nuevas', '2025-07-03 02:16:52'),
(2, '1110174520', 'BOB587', 'Bueno', '2025-07-08', 10.50, 5455445, 45555, '2025-07-16', 'comooooo si supiera', '2025-07-12 18:55:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `logs_sistema`
--

CREATE TABLE `logs_sistema` (
  `id` int(11) NOT NULL,
  `usuario` varchar(100) DEFAULT NULL,
  `accion` varchar(255) DEFAULT NULL,
  `descripcion` text DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `logs_sistema`
--

INSERT INTO `logs_sistema` (`id`, `usuario`, `accion`, `descripcion`, `fecha`, `ip_address`) VALUES
(1, '1109491416', 'Licencia creada', 'Nueva licencia creada para SENA', '2025-07-05 14:26:46', '::1'),
(1109491416, 'Edwar Farid Gomez Sanchez', 'creada', 'Nueva licencia creada para SENA', '2025-07-05 16:04:15', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_accesos_superadmin`
--

CREATE TABLE `log_accesos_superadmin` (
  `id` int(11) NOT NULL,
  `documento` varchar(20) NOT NULL,
  `fecha_acceso` datetime NOT NULL,
  `ip_acceso` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `log_accesos_superadmin`
--

INSERT INTO `log_accesos_superadmin` (`id`, `documento`, `fecha_acceso`, `ip_acceso`) VALUES
(1, '1109491416', '2025-07-04 19:44:53', '::1'),
(2, '1109491416', '2025-07-04 19:45:32', '::1'),
(3, '1109491416', '2025-07-04 19:45:38', '::1'),
(4, '1109491416', '2025-07-04 19:50:54', '::1'),
(5, '1109491416', '2025-07-04 19:51:20', '::1'),
(6, '1109491416', '2025-07-04 19:57:20', '::1'),
(7, '1109491416', '2025-07-04 20:11:12', '::1'),
(8, '1109491416', '2025-07-04 20:11:14', '::1'),
(9, '1109491416', '2025-07-04 20:12:49', '::1'),
(10, '1109491416', '2025-07-04 20:18:59', '::1'),
(11, '1109491416', '2025-07-04 20:27:27', '::1'),
(12, '1109491416', '2025-07-04 20:37:39', '::1'),
(13, '1109491416', '2025-07-04 20:48:58', '::1'),
(14, '1109491416', '2025-07-05 09:08:09', '::1'),
(15, '1109491416', '2025-07-05 09:12:42', '::1'),
(16, '1109491416', '2025-07-05 10:15:23', '::1'),
(17, '1109491416', '2025-07-05 10:15:44', '::1'),
(18, '1109491416', '2025-07-05 10:44:10', '::1'),
(19, '1109491416', '2025-07-05 10:45:41', '::1'),
(20, '1110174520', '2025-07-14 14:33:30', '::1'),
(21, '1110174520', '2025-07-14 15:40:40', '::1'),
(22, '1110174520', '2025-07-15 11:44:16', '::1');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `log_registros`
--

CREATE TABLE `log_registros` (
  `id_log` int(11) NOT NULL,
  `documento_usuario` varchar(20) DEFAULT NULL,
  `email_usuario` varchar(100) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp(),
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `log_registros`
--

INSERT INTO `log_registros` (`id_log`, `documento_usuario`, `email_usuario`, `fecha_registro`, `descripcion`) VALUES
(1, '1109490190', 'milady@gmail.com', '2025-06-17 22:00:36', 'Nuevo Usuario registrado'),
(2, '8764534254', 'edwardfarsidg@gmail.com', '2025-06-18 01:51:30', 'Nuevo Usuario registrado'),
(3, '123456780', 'mauro@gmail.com', '2025-06-25 00:07:20', 'Nuevo Usuario registrado'),
(4, '1109492268', 'Dairon@gmail.com', '2025-06-25 00:33:34', 'Nuevo Usuario registrado'),
(5, '1110174519', 'valenguevara87@gmail.com', '2025-06-25 03:41:56', 'Nuevo Usuario registrado'),
(6, '1104941185', 'adriancamargo69@gmail.com', '2025-06-27 15:46:22', 'Nuevo Usuario registrado'),
(7, '1110174520', 'Carlosgo1821@gmail.com', '2025-06-28 15:29:40', 'Nuevo Usuario registrado'),
(8, '1110174530', 'federico@gmail.com', '2025-06-28 16:33:43', 'Nuevo Usuario registrado'),
(9, '1110174530', 'federico@gmail.com', '2025-06-28 16:37:29', 'Nuevo Usuario registrado'),
(10, '1110174530', 'federico@gmail.com', '2025-06-28 16:52:23', 'Nuevo Usuario registrado'),
(11, '987654321', 'admin@gmail.com', '2025-06-30 00:45:07', 'Nuevo Usuario registrado'),
(12, '1109385178', 'tairasofia@gmail.com', '2025-07-01 19:42:58', 'Nuevo Usuario registrado'),
(13, '1109492268', 'dairon@gmail.com', '2025-07-02 06:42:25', 'Nuevo Usuario registrado'),
(14, '0000000000', 'superadmin@fleetmanager.com', '2025-07-04 19:36:26', 'Nuevo Usuario registrado'),
(15, '8588283823', 'alvarezmoraisa@gmail.com', '2025-07-05 08:25:36', 'Nuevo Usuario registrado'),
(16, '321654987', 'sahur@gmail.com', '2025-07-11 20:00:39', 'Nuevo Usuario registrado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mantenimiento`
--

CREATE TABLE `mantenimiento` (
  `id_mantenimiento` int(11) NOT NULL,
  `placa` varchar(10) NOT NULL,
  `id_tipo_mantenimiento` varchar(50) NOT NULL,
  `fecha_programada` date NOT NULL,
  `fecha_realizada` date DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `kilometraje_actual` int(11) DEFAULT NULL,
  `proximo_cambio_km` int(11) DEFAULT NULL,
  `proximo_cambio_fecha` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mantenimiento`
--

INSERT INTO `mantenimiento` (`id_mantenimiento`, `placa`, `id_tipo_mantenimiento`, `fecha_programada`, `fecha_realizada`, `observaciones`, `kilometraje_actual`, `proximo_cambio_km`, `proximo_cambio_fecha`) VALUES
(4, 'UVG099', '1', '2025-06-29', '2025-06-29', 'Cambios de aceite', 212321, 2132122, '2025-07-02'),
(5, 'GZM57D', '1', '2025-06-29', '2025-06-29', 'Cambios', 21321, 23123, '2025-07-02'),
(6, 'CAR333', '1', '2025-07-08', '2025-01-15', 'Holaaa', 6546312, 6546544, '2025-07-05'),
(7, 'MOM202', '1', '2025-07-02', '2025-07-02', 'mantenimiento general', 1000, 50000, '2025-11-02'),
(8, 'AAS232', '2', '2025-07-05', '2025-07-05', 'Accidetne abolladura', 77887888, 555555, '2025-11-06'),
(10, 'SIM213', '1', '2025-07-17', '2025-07-10', 'nada', 5665, 6546565, '2025-07-19');

--
-- Disparadores `mantenimiento`
--
DELIMITER $$
CREATE TRIGGER `after_insert_mantenimiento` AFTER INSERT ON `mantenimiento` FOR EACH ROW BEGIN
  DECLARE doc_usuario VARCHAR(20);

  -- Buscar el documento del usuario a partir de la placa
  SELECT Documento INTO doc_usuario
  FROM vehiculos
  WHERE placa = NEW.placa
  LIMIT 1;

  -- Insertar en el log
  INSERT INTO mantenimiento_log (
    documento_usuario,
    placa_vehiculo,
    id_tipo_mantenimiento,
    fecha_programada,
    fecha_realizada,
    kilometraje_actual,
    proximo_cambio_km,
    proximo_cambio_fecha,
    observaciones
  ) VALUES (
    doc_usuario,
    NEW.placa,
    NEW.id_tipo_mantenimiento,
    NEW.fecha_programada,
    NEW.fecha_realizada,
    NEW.kilometraje_actual,
    NEW.proximo_cambio_km,
    NEW.proximo_cambio_fecha,
    NEW.observaciones
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mantenimiento_log`
--

CREATE TABLE `mantenimiento_log` (
  `id_log` int(11) NOT NULL,
  `documento_usuario` varchar(20) DEFAULT NULL,
  `placa_vehiculo` varchar(10) DEFAULT NULL,
  `id_tipo_mantenimiento` int(11) DEFAULT NULL,
  `fecha_programada` date DEFAULT NULL,
  `fecha_realizada` date DEFAULT NULL,
  `kilometraje_actual` int(11) DEFAULT NULL,
  `proximo_cambio_km` int(11) DEFAULT NULL,
  `proximo_cambio_fecha` date DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `mantenimiento_log`
--

INSERT INTO `mantenimiento_log` (`id_log`, `documento_usuario`, `placa_vehiculo`, `id_tipo_mantenimiento`, `fecha_programada`, `fecha_realizada`, `kilometraje_actual`, `proximo_cambio_km`, `proximo_cambio_fecha`, `observaciones`, `fecha_registro`) VALUES
(1, '1109491416', 'MOM202', 1, '2025-07-02', '2025-07-02', 1000, 50000, '2025-11-02', 'mantenimiento general', '2025-07-03 02:19:20'),
(2, '1234567890', 'AAS232', 2, '2025-07-05', '2025-07-05', 77887888, 555555, '2025-11-06', 'Accidetne abolladura', '2025-07-05 08:41:00'),
(3, '1110174520', 'BOB587', 1, '2025-07-11', '2025-07-12', 65645, 5466546, '2025-07-25', 'siuuuuuuu', '2025-07-12 01:18:37'),
(4, '1110174520', 'SIM213', 1, '2025-07-17', '2025-07-10', 5665, 6546565, '2025-07-19', 'nada', '2025-07-15 18:39:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `marca`
--

CREATE TABLE `marca` (
  `id_marca` int(11) NOT NULL,
  `nombre_marca` varchar(50) NOT NULL,
  `id_tipo_vehiculo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `marca`
--

INSERT INTO `marca` (`id_marca`, `nombre_marca`, `id_tipo_vehiculo`) VALUES
(1, 'Chevrolet', 1),
(2, 'Toyota', 1),
(3, 'Mazda', 1),
(4, 'Kia', 1),
(5, 'Renault', 1),
(6, 'Hyundai', 1),
(7, 'Volkswagen', 1),
(8, 'Nissan', 1),
(9, 'Ford', 1),
(10, 'Honda', 1),
(11, 'Peugeot', 1),
(12, 'Fiat', 1),
(13, 'Skoda', 1),
(14, 'Subaru', 1),
(15, 'Lada', 1),
(16, 'AKT', 2),
(17, 'Yamaha', 2),
(18, 'Suzuki', 2),
(19, 'Honda', 2),
(20, 'Bajaj', 2),
(21, 'KTM', 2),
(22, 'TVS', 2),
(23, 'Royal Enfield', 2),
(24, 'Hero', 2),
(25, 'Benelli', 2),
(26, 'Harley-Davidson', 2),
(27, 'Aprilia', 2),
(28, 'Ducati', 2),
(29, 'BMW Motorrad', 2),
(30, 'Toyota', 3),
(31, 'Mazda', 3),
(32, 'Chevrolet', 3),
(33, 'Nissan', 3),
(34, 'Ford', 3),
(35, 'Hyundai', 3),
(36, 'Mitsubishi', 3),
(37, 'Volkswagen', 3),
(38, 'Jeep', 3),
(39, 'Kia', 3),
(40, 'Freightliner', 4),
(41, 'Kenworth', 4),
(42, 'Volvo', 4),
(43, 'Hino', 4),
(44, 'International', 4),
(45, 'Isuzu', 4),
(46, 'Mack', 4),
(47, 'Scania', 4),
(48, 'Mercedes-Benz', 4),
(49, 'MAN', 4),
(50, 'Mercedes-Benz', 5),
(51, 'Chevrolet', 5),
(52, 'Volkswagen', 5),
(53, 'Hino', 5),
(54, 'Renault', 5),
(55, 'Hyundai', 5),
(56, 'Toyota', 5),
(57, 'Nissan', 5),
(58, 'Volvo', 5),
(59, 'Scania', 5),
(60, 'Ford', 6),
(61, 'Toyota', 6),
(62, 'Chevrolet', 6),
(63, 'Nissan', 6),
(64, 'Mitsubishi', 6),
(65, 'Jeep', 7),
(66, 'Ford', 7),
(67, 'Toyota', 7),
(68, 'Hyundai', 7),
(69, 'Mazda', 7),
(70, 'Chevrolet', 7),
(71, 'Kia', 8),
(72, 'Hyundai', 8),
(73, 'Nissan', 8),
(74, 'Subaru', 8),
(75, 'Toyota', 8),
(76, 'Mazda', 8),
(77, 'Chevrolet', 9),
(78, 'Renault', 9),
(79, 'Hyundai', 9),
(80, 'Ford', 9),
(81, 'Toyota', 9),
(82, 'Kenworth', 10),
(83, 'Volvo', 10),
(84, 'Freightliner', 10),
(85, 'Scania', 10),
(86, 'International', 10);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` int(11) NOT NULL,
  `documento_usuario` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mensaje` text NOT NULL,
  `fecha` timestamp NULL DEFAULT current_timestamp(),
  `leido` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `notificaciones`
--

INSERT INTO `notificaciones` (`id`, `documento_usuario`, `mensaje`, `fecha`, `leido`) VALUES
(1, '1234567890', '🔧 Hola Instructor cesar, el cambio de llantas de tu vehículo con placa GAS900 está programado para el 2025-07-05. Por favor agenda tu mantenimiento.', '2025-07-02 00:25:51', 0),
(2, '1234567890', '🔧 Hola Instructor cesar, el cambio de llantas de tu vehículo con placa GAS900 está programado para el 2025-07-05. Por favor agenda tu mantenimiento.', '2025-07-02 00:41:57', 0),
(3, '1234567890', '🔧 Hola Instructor cesar, el cambio de llantas de tu vehículo con placa GAS900 está programado para el 2025-07-05. Por favor agenda tu mantenimiento.', '2025-07-02 00:42:29', 0),
(4, '1110174530', '🔧 Hola federico, el cambio de llantas de tu vehículo con placa CAR333 está programado para el 2025-07-05. Por favor agenda tu mantenimiento.', '2025-07-02 00:42:29', 0),
(5, '1109490190', '🚫 Hola Francy , los siguientes vehículos tienen pico y placa hoy (Martes): KKK333.', '2025-07-02 01:31:34', 0),
(6, '1234567890', '🚫 Hola Instructor cesar, los siguientes vehículos tienen pico y placa hoy (Martes): ASD213.', '2025-07-02 01:31:35', 0),
(7, '9876543210', '🚫 Hola carlos, los siguientes vehículos tienen pico y placa hoy (Martes): KSK234.', '2025-07-02 01:31:35', 0),
(8, '1109490190', '🚫 Hola Francy , los siguientes vehículos tienen pico y placa hoy (Martes): KKK333.', '2025-07-02 01:49:24', 0),
(9, '1110174530', '🚫 Hola federico, los siguientes vehículos tienen pico y placa hoy (Martes): CAR333.', '2025-07-02 01:49:25', 1),
(10, '1234567890', '🚫 Hola Instructor cesar, los siguientes vehículos tienen pico y placa hoy (Martes): ASD213.', '2025-07-02 01:49:25', 0),
(11, '9876543210', '🚫 Hola carlos, los siguientes vehículos tienen pico y placa hoy (Martes): KSK234.', '2025-07-02 01:49:25', 0),
(12, '1110174530', '🔧 Hola federico, recuerda que el mantenimiento de tu vehículo con placa CAR333 está programado para el 2025-07-05. ¡No lo dejes pasar!', '2025-07-02 01:56:26', 1),
(13, '1110174530', '📋 Hola federico, tu licencia categoría 5 vence el 2025-07-05. Por favor, renuévala a tiempo para evitar sanciones.', '2025-07-02 02:10:06', 1),
(14, '1110174530', '🛡️ Hola federico, el SOAT de tu vehículo con placa CAR333 vence el 2025-07-05. No olvides renovarlo a tiempo.', '2025-07-02 02:14:29', 1),
(15, '1110174530', '🔧 Hola federico, la técnico-mecánica de tu vehículo con placa CAR333 vence el 2025-07-05. Recuerda renovarla a tiempo.', '2025-07-02 02:18:26', 1),
(16, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:27:59', 1),
(17, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:27:59', 1),
(18, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:28:12', 1),
(19, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:28:13', 1),
(20, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:28:14', 1),
(21, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:28:15', 1),
(22, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:28:19', 1),
(23, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:30:04', 1),
(24, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:30:06', 1),
(25, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:30:12', 1),
(26, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:30:15', 1),
(27, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:30:16', 1),
(28, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:31:13', 1),
(29, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:31:16', 1),
(30, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:31:19', 1),
(31, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:31:32', 1),
(32, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:32:15', 1),
(33, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:32:21', 1),
(34, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:32:33', 1),
(35, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:32:33', 1),
(36, '1109491416', 'Tu SOAT está próximo a vencer.', '2025-07-02 15:32:35', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pico_placa`
--

CREATE TABLE `pico_placa` (
  `id_pico_placa` int(11) NOT NULL,
  `anio` int(11) NOT NULL,
  `semestre` enum('1','2') NOT NULL,
  `dia` enum('Lunes','Martes','Miercoles','Jueves','Viernes') NOT NULL,
  `digitos_restringidos` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pico_placa`
--

INSERT INTO `pico_placa` (`id_pico_placa`, `anio`, `semestre`, `dia`, `digitos_restringidos`) VALUES
(3, 2025, '2', 'Lunes', '1,2'),
(4, 2025, '2', 'Martes', '3,4'),
(5, 2025, '2', 'Miercoles', '5,6'),
(6, 2025, '2', 'Jueves', '7,8'),
(7, 2025, '2', 'Viernes', '9,0');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registro_vehiculos_log`
--

CREATE TABLE `registro_vehiculos_log` (
  `id_log` int(11) NOT NULL,
  `documento_usuario` varchar(20) DEFAULT NULL,
  `placa_vehiculo` varchar(10) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id_rol` int(11) NOT NULL,
  `tip_rol` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id_rol`, `tip_rol`) VALUES
(1, 'Administrador'),
(2, 'Usuario'),
(3, 'Superadmin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicios_licencias`
--

CREATE TABLE `servicios_licencias` (
  `id_servicio` int(11) NOT NULL,
  `nombre_servicios` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicios_licencias`
--

INSERT INTO `servicios_licencias` (`id_servicio`, `nombre_servicios`) VALUES
(1, 'Particular'),
(2, 'Publico');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sistema_licencias`
--

CREATE TABLE `sistema_licencias` (
  `id` int(11) NOT NULL,
  `usuario_asignado` varchar(20) NOT NULL,
  `tipo_licencia` enum('basica','profesional','empresarial') DEFAULT 'basica',
  `fecha_inicio` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `max_usuarios` int(11) DEFAULT 10,
  `max_vehiculos` int(11) DEFAULT 50,
  `estado` enum('activa','vencida','suspendida') DEFAULT 'activa',
  `clave_licencia` varchar(255) DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sistema_licencias`
--

INSERT INTO `sistema_licencias` (`id`, `usuario_asignado`, `tipo_licencia`, `fecha_inicio`, `fecha_vencimiento`, `max_usuarios`, `max_vehiculos`, `estado`, `clave_licencia`, `fecha_creacion`, `fecha_actualizacion`) VALUES
(1, '1110174520', 'empresarial', '2025-07-13', '2026-07-13', 100, 500, 'activa', 'LIC-ABC123456789', '2025-07-14 20:48:43', '2025-07-14 20:48:43'),
(2, '1110174530', 'basica', '2025-07-08', '2025-07-24', 10, 50, 'activa', '123456789', '2025-07-15 20:17:36', '2025-07-15 22:04:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `soat`
--

CREATE TABLE `soat` (
  `id_soat` int(11) NOT NULL,
  `id_placa` varchar(10) NOT NULL,
  `fecha_expedicion` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `id_aseguradora` int(11) NOT NULL,
  `id_estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `soat`
--

INSERT INTO `soat` (`id_soat`, `id_placa`, `fecha_expedicion`, `fecha_vencimiento`, `id_aseguradora`, `id_estado`) VALUES
(2, 'CAR333', '2024-07-05', '2025-07-05', 22, 1),
(3, 'MOM202', '2025-07-02', '2026-07-02', 28, 1);

--
-- Disparadores `soat`
--
DELIMITER $$
CREATE TRIGGER `after_insert_soat` AFTER INSERT ON `soat` FOR EACH ROW BEGIN
  DECLARE doc_usuario VARCHAR(20);

  -- Buscar el documento del usuario a partir de la placa
  SELECT Documento INTO doc_usuario
  FROM vehiculos
  WHERE placa = NEW.id_placa
  LIMIT 1;

  -- Insertar en la tabla log
  INSERT INTO soat_log (
    documento_usuario,
    placa_vehiculo,
    fecha_expedicion,
    fecha_vencimiento,
    id_aseguradora,
    estado
  ) VALUES (
    doc_usuario,
    NEW.id_placa,
    NEW.fecha_expedicion,
    NEW.fecha_vencimiento,
    NEW.id_aseguradora,
    NEW.id_estado
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `soat_log`
--

CREATE TABLE `soat_log` (
  `id_log` int(11) NOT NULL,
  `documento_usuario` varchar(20) DEFAULT NULL,
  `placa_vehiculo` varchar(10) DEFAULT NULL,
  `fecha_expedicion` date DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `id_aseguradora` int(11) DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `soat_log`
--

INSERT INTO `soat_log` (`id_log`, `documento_usuario`, `placa_vehiculo`, `fecha_expedicion`, `fecha_vencimiento`, `id_aseguradora`, `estado`, `fecha_registro`) VALUES
(1, '1109491416', 'MOM202', '2025-07-02', '2026-07-02', 28, 1, '2025-07-03 02:13:56'),
(2, '1110174520', 'BOB587', '2024-10-13', '2025-10-13', 26, 1, '2025-07-12 17:49:16');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `talleres`
--

CREATE TABLE `talleres` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `latitud` decimal(10,8) DEFAULT NULL,
  `longitud` decimal(11,8) DEFAULT NULL,
  `ciudad` varchar(100) DEFAULT NULL,
  `estado` enum('activo','inactivo') DEFAULT 'activo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `talleres`
--

INSERT INTO `talleres` (`id`, `nombre`, `direccion`, `telefono`, `latitud`, `longitud`, `ciudad`, `estado`) VALUES
(1, 'Arg Automotriz', 'Cra. 4 Tamaná 27-84, Ibagué', NULL, 4.44028000, -75.23230000, 'Ibagué', 'activo'),
(2, 'Tecniservicios JE', 'Cl. 26, Ibagué', NULL, 4.43942000, -75.23655000, 'Ibagué', 'activo'),
(3, 'Frenos del Tolima', 'Cra. 5 #95-13, Ibagué', NULL, 4.45321000, -75.23231000, 'Ibagué', 'activo'),
(4, 'Ingemotor', 'Calle 24 #1-39, Ibagué', '+57 304 1290992', 4.44188000, -75.23948000, 'Ibagué', 'activo'),
(5, 'Linautos', 'Carrera 2A No. 27-51, Claret, Ibagué', '300 674 3616', 4.44321000, -75.24095000, 'Ibagué', 'activo'),
(6, 'Taller J Pablo', 'Cl. 24 #4a-46, Ibagué', '315 8517360', 4.44197000, -75.23723000, 'Ibagué', 'activo'),
(7, 'AE Rines', 'Calle 24 #7-21, Ibagué', '(608) 2610957', 4.44173000, -75.23499000, 'Ibagué', 'activo'),
(8, 'Auto Fenix Express SAS', 'Calle 23 #5A-48, Ibagué', '324 2820779', 4.44105000, -75.23653000, 'Ibagué', 'activo'),
(9, 'Frenos Estefan', 'Calle 27 No. 4B-28, Hipódromo, Ibagué', '304 4246849', 4.44436000, -75.23588000, 'Ibagué', 'activo'),
(10, 'Taller Teomotos', 'Av. Ambalá 34-21, Ibagué', '310 8820325', 4.44826000, -75.22248000, 'Ibagué', 'activo'),
(11, 'Taller Eléctrico Auto Vidal', 'Cra. 7 #21-21, Ibagué', '(608) 2625188', 4.43966000, -75.23210000, 'Ibagué', 'activo'),
(12, 'Autotechnik Performance', 'Cl. 23A #7-34, Ibagué', '320 9624881', 4.44071000, -75.23451000, 'Ibagué', 'activo'),
(13, 'Taller Hernandez Mecanica Automotriz SAS', 'Cra. 1 N 22 04, Ibagué', '3124226485', 4.44150000, -75.23250000, 'Ibagué', 'activo'),
(14, 'Uno A Automotriz', 'Ibagué', NULL, 4.44400000, -75.23200000, 'Ibagué', 'activo'),
(15, 'Taller ExpressCar', 'Calle 23 #5-71, Barrio El Carmen, Ibagué', '3115284165', 4.44376000, -75.23251000, 'Ibagué', 'activo'),
(16, 'Arc Los Restrepo S.A.S.', 'Ibagué', NULL, 4.44280000, -75.23320000, 'Ibagué', 'activo'),
(17, 'Embragues y Repuestos del Tolima', 'Ibagué', NULL, 4.44220000, -75.23390000, 'Ibagué', 'activo'),
(18, 'Kenworth de la Montaña', 'Ibagué', NULL, 4.43550000, -75.22450000, 'Ibagué', 'activo'),
(19, 'Taller Hernandez Mecanica Automotriz SAS', 'Cra. 1 N 22 04, Ibagu&eacute;', '3124226485', 4.44150000, -75.23250000, 'Ibagu&eacute;', 'activo'),
(20, 'Uno A Automotriz', 'Ibagu&eacute;', NULL, 4.44400000, -75.23200000, 'Ibagu&eacute;', 'activo'),
(21, 'Taller ExpressCar', 'Calle 23 #5-71, Barrio El Carmen, Ibagu&eacute;', '3115284165', 4.44376000, -75.23251000, 'Ibagu&eacute;', 'activo'),
(22, 'Arc Los Restrepo S.A.S.', 'Ibagu&eacute;', NULL, 4.44280000, -75.23320000, 'Ibagu&eacute;', 'activo'),
(23, 'Embragues y Repuestos del Tolima', 'Ibagu&eacute;', NULL, 4.44220000, -75.23390000, 'Ibagu&eacute;', 'activo'),
(24, 'Kenworth de la Monta&ntilde;a', 'Ibagu&eacute;', NULL, 0.00000000, 0.00000000, 'Ibagu&eacute;', 'activo'),
(25, 'Taller Hernandez Mecanica Automotriz SAS', 'Cra. 1 N 22 04, Ibagué', '3124226485', 4.44150000, -75.23250000, 'Ibagué', 'activo'),
(26, 'Uno A Automotriz', 'Ibagué', NULL, 4.44400000, -75.23200000, 'Ibagué', 'activo'),
(27, 'Taller ExpressCar', 'Calle 23 #5-71, Barrio El Carmen, Ibagué', '3115284165', 4.44376000, -75.23251000, 'Ibagué', 'activo'),
(28, 'Arc Los Restrepo S.A.S.', 'Ibagué', NULL, 4.44280000, -75.23320000, 'Ibagué', 'activo'),
(29, 'Embragues y Repuestos del Tolima', 'Ibagué', NULL, 4.44220000, -75.23390000, 'Ibagué', 'activo'),
(30, 'Kenworth de la Montaña', 'Ibagué', NULL, 4.43550000, -75.22450000, 'Ibagué', 'activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnomecanica`
--

CREATE TABLE `tecnomecanica` (
  `id_rtm` int(11) NOT NULL,
  `id_placa` varchar(11) NOT NULL,
  `id_centro_revision` int(11) NOT NULL,
  `fecha_expedicion` date NOT NULL,
  `fecha_vencimiento` date NOT NULL,
  `id_estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tecnomecanica`
--

INSERT INTO `tecnomecanica` (`id_rtm`, `id_placa`, `id_centro_revision`, `fecha_expedicion`, `fecha_vencimiento`, `id_estado`) VALUES
(2, 'CAR333', 3, '2024-07-05', '2025-07-05', 1),
(3, 'MOM202', 2, '2025-07-02', '2026-07-02', 1);

--
-- Disparadores `tecnomecanica`
--
DELIMITER $$
CREATE TRIGGER `after_insert_tecnomecanica` AFTER INSERT ON `tecnomecanica` FOR EACH ROW BEGIN
  DECLARE doc_usuario VARCHAR(20);
  
  -- Obtener el documento del usuario desde la tabla vehiculos
  SELECT Documento INTO doc_usuario
  FROM vehiculos
  WHERE placa = NEW.id_placa
  LIMIT 1;

  -- Insertar en el log
  INSERT INTO tecnomecanica_log (
    documento_usuario,
    placa_vehiculo,
    centro_revision,
    fecha_expedicion,
    fecha_vencimiento,
    estado
  ) VALUES (
    doc_usuario,
    NEW.id_placa,
    NEW.id_centro_revision,
    NEW.fecha_expedicion,
    NEW.fecha_vencimiento,
    NEW.id_estado
  );
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tecnomecanica_log`
--

CREATE TABLE `tecnomecanica_log` (
  `id_log` int(11) NOT NULL,
  `documento_usuario` varchar(20) DEFAULT NULL,
  `placa_vehiculo` varchar(10) DEFAULT NULL,
  `centro_revision` int(11) DEFAULT NULL,
  `fecha_expedicion` date DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `fecha_registro` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tecnomecanica_log`
--

INSERT INTO `tecnomecanica_log` (`id_log`, `documento_usuario`, `placa_vehiculo`, `centro_revision`, `fecha_expedicion`, `fecha_vencimiento`, `estado`, `fecha_registro`) VALUES
(1, '1109491416', 'MOM202', 2, '2025-07-02', '2026-07-02', 1, '2025-07-03 02:20:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_documentacion`
--

CREATE TABLE `tipo_documentacion` (
  `id_tipo_documento` varchar(50) NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_gasto`
--

CREATE TABLE `tipo_gasto` (
  `id_tipo_gasto` varchar(50) NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_mantenimiento`
--

CREATE TABLE `tipo_mantenimiento` (
  `id_tipo_mantenimiento` varchar(50) NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_mantenimiento`
--

INSERT INTO `tipo_mantenimiento` (`id_tipo_mantenimiento`, `descripcion`) VALUES
('1', 'Preventivo'),
('2', 'Correctivo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_vehiculo`
--

CREATE TABLE `tipo_vehiculo` (
  `id_tipo_vehiculo` int(11) NOT NULL,
  `vehiculo` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_vehiculo`
--

INSERT INTO `tipo_vehiculo` (`id_tipo_vehiculo`, `vehiculo`) VALUES
(1, 'Automovil'),
(2, 'Motocicleta'),
(3, 'Camioneta'),
(4, 'Camión'),
(5, 'Bus'),
(6, 'Pickup'),
(7, 'SUV'),
(8, 'Crossover'),
(9, 'Van'),
(10, 'Tractomula');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `documento` varchar(20) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(500) NOT NULL,
  `telefono` bigint(20) NOT NULL,
  `id_estado_usuario` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_expira` datetime DEFAULT NULL,
  `joined_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `foto_perfil` varchar(255) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `nit_empresa` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`documento`, `nombre_completo`, `email`, `password`, `telefono`, `id_estado_usuario`, `id_rol`, `reset_token`, `reset_expira`, `joined_at`, `foto_perfil`, `fecha_nacimiento`, `nit_empresa`) VALUES
('0000000000', 'Super Administrador', 'superadmin@gmail.com', '$2y$12$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1234567890, 1, 3, NULL, NULL, '2025-07-12 00:57:11', NULL, NULL, NULL),
('1104941185', 'Adrian', 'adriancamargo69@gmail.com', '$2y$12$eZp.yNs5bbMdzgZaYk9j/OrphFC3hyE/vVsugnDC2pdhH/QlHTqHK', 3108571293, 1, 2, NULL, NULL, '2025-07-05 13:24:33', '../usuario/css/img/perfil.jpg', NULL, NULL),
('1109490190', 'Francy ', 'milady@gmail.com', '$2y$12$mnEQujlWFNQne.N4F1oAVOupVLYX6cYwkT5L6QvxMCUgop6bvcwYy', 3138102150, 1, 2, NULL, NULL, '2025-06-25 13:57:54', '/roles/usuario/css/img/perfil.jpg', NULL, NULL),
('1109491416', 'Edwar Farid Gomez Sanchez', 'edwardfaridg@gmail.com', '$2y$12$tzKF310HKlVIyqjSoSwNGu89giC0LhKXZcds0wwKo6sapRzARjl7q', 3138102150, 1, 3, NULL, NULL, '2025-07-05 14:08:04', '../usuario/css/img/perfil.jpg', '2006-05-04', NULL),
('1109492268', 'dairon', 'dairon@gmail.com', '$2y$12$5dDyJulkLSjkfjN0D34E6uzYk8F/zFHVYYqWXMzBGKwSVT2uTzeui', 9876543234, 1, 2, NULL, NULL, '2025-07-02 06:42:25', '/roles/usuario/css/img/perfil.jpg', NULL, NULL),
('1110174519', 'valentina Guevara', 'valenguevara87@gmail.com', '$2y$12$IDNXcdqyLb9XuWCCWY42Y.brEX19/OXJ1loUF1I8BHH5RnT6CcRke', 3138102150, 1, 2, NULL, NULL, '2025-06-25 13:58:14', '/roles/usuario/css/img/1110174519_1750822972.jpg', NULL, NULL),
('1110174520', 'carlos guevara', 'Carlosgo1821@gmail.com', '$2y$12$MAgCufJELnEVX4cFiDIKBuBqIT5P8a.ge5Oyeqmsw2OjMzq6TnfkK', 1111111111, 1, 2, NULL, NULL, '2025-07-15 23:37:13', NULL, NULL, NULL),
('1110174530', 'federico', 'federico23@gmail.com', '$2y$12$rd/x5rnPh.BGCq6yoF5sMORDQhV1WCI9JyU8owA3Y9GgZyOgxZUHi', 3138102150, 1, 1, NULL, NULL, '2025-07-16 01:47:58', '../usuario/css/img/perfil.jpg', '2004-02-05', NULL),
('123456780', 'Mauro', 'mauro@gmail.com', '$2y$12$.N1fNQ8IoLeARtiheiHIMeSQKBqJXcByepovREaMyY3lFSL8sK1rC', 3138102150, 1, 2, NULL, NULL, '2025-06-25 13:58:22', NULL, NULL, NULL),
('1234567890', 'Instructor cesar', 'instructor@gmail.com', '$2y$12$AlVGKX55fPkNLa7LbRzAjeaWFg2hUmVeoCf8T0FB2P6YoOAc79FEi', 3138102150, 1, 2, NULL, NULL, '2025-06-25 13:58:33', NULL, NULL, NULL),
('321654987', 'tun tun sahur de las mercedes', 'sahur@gmail.com', '$2y$10$rnHjvCUh3nfTDR5Ufpd/l.Z1x/ZoAc/lRG4icFREyhRxFUmKkMBtC', 3222566552, 1, 2, NULL, NULL, '2025-07-12 01:01:21', NULL, NULL, NULL),
('8588283823', 'isabella', 'alvarezmoraisa@gmail.com', '$2y$10$xn4VHSZzuk2j.LZ4Y8vbJujkYMXL5SXvGr029fQRn5avZouao07Ry', 3102331155, 1, 2, NULL, NULL, '2025-07-05 13:25:36', NULL, NULL, NULL),
('8764534254', 'PEPITO', 'edwardfarsidg@gmail.com', '$2y$12$BlnRnJCmkWtWnE6e4Q2ZCOuEluq4r0Gx0q9DDAEu0PqHbxoK71.LC', 3138102150, 1, 2, NULL, NULL, '2025-06-25 13:58:43', NULL, NULL, NULL),
('987654321', 'admin', 'admin@gmail.com', '$2y$12$MlKgR3yaE/DWjGBn/AswkejpcchJvRbF3xJEPNRK68zQrJ41CU/O6', 3209790912, 1, 1, NULL, NULL, '2025-07-02 00:00:01', '/roles/usuario/css/img/987654321_1751414401.jpeg', NULL, NULL),
('9876543210', 'carlos', 'Carlosgo1822@gmail.com', '$2y$10$FUKgva81QgWzPiqDtthX6uRfD7Fv9.wSjOar6lsHLc0HucyJjofQO', 3138102150, 1, 2, NULL, NULL, '2025-06-23 06:43:42', '/roles/usuario/css/img/9876543210_1750392408.png', '2002-07-18', NULL);

--
-- Disparadores `usuarios`
--
DELIMITER $$
CREATE TRIGGER `after_insert_usuario` AFTER INSERT ON `usuarios` FOR EACH ROW BEGIN
    INSERT INTO log_registros(documento_usuario, email_usuario, descripcion)
    VALUES (NEW.documento, NEW.email, CONCAT('Nuevo Usuario registrado'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculos`
--

CREATE TABLE `vehiculos` (
  `placa` varchar(10) NOT NULL,
  `tipo_vehiculo` int(11) NOT NULL,
  `Documento` varchar(20) NOT NULL,
  `id_marca` varchar(50) NOT NULL,
  `modelo` varchar(50) NOT NULL,
  `kilometraje_actual` bigint(20) NOT NULL,
  `id_estado` varchar(50) NOT NULL,
  `fecha_registro` date NOT NULL,
  `foto_vehiculo` varchar(255) DEFAULT NULL COMMENT 'Ruta de la imagen del vehículo',
  `registrado_por` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `vehiculos`
--

INSERT INTO `vehiculos` (`placa`, `tipo_vehiculo`, `Documento`, `id_marca`, `modelo`, `kilometraje_actual`, `id_estado`, `fecha_registro`, `foto_vehiculo`, `registrado_por`) VALUES
('AAS232', 1, '1234567890', '2', '2021', 21233213, '10', '2025-06-11', 'vehiculos/listar/guardar_foto_vehiculo/sin_foto_carro.png', NULL),
('AGS21G', 2, '1234567890', '16', '2020', 12345678, '10', '2025-06-11', 'vehiculos/listar/guardar_foto_vehiculo/sin_foto_carro.png', NULL),
('ASD213', 1, '1234567890', '3', '2022', 1234567, '10', '2025-06-11', 'vehiculos/listar/guardar_foto_vehiculo/sin_foto_carro.png', NULL),
('ASD231', 1, '1234567890', '1', '2021', 100029, '10', '2025-06-01', 'vehiculos/listar/guardar_foto_vehiculo/sin_foto_carro.png', NULL),
('CAR333', 4, '1109492268', '35', '2023', 65645653, '3', '2025-07-01', 'vehiculo_6868dbf505d78.jpg', NULL),
('DAS231', 8, '1234567890', '73', '2020', 1123456, '10', '2025-06-11', 'vehiculos/listar/guardar_foto_vehiculo/sin_foto_carro.png', NULL),
('DFD545', 1, '1110174520', '1', '2020', 54545, '10', '2025-07-09', 'vehiculo_686dafa1dd41a.jpg', NULL),
('FKD454', 1, '1109491416', '1', '2022', 56456, '7', '2025-07-09', 'MOOOOOOOOOTOA.jfif', NULL),
('GAS900', 3, '1234567890', '36', '2025', 12345678, '10', '2025-06-11', 'vehiculos/listar/guardar_foto_vehiculo/sin_foto_carro.png', NULL),
('GZM57D', 2, '1104941185', '17', '2022', 40000, '10', '2025-06-27', 'vehiculo_686c59d2286c8.jpg', NULL),
('HTM129', 4, '9876543210', '43', '2020', 51325, '5', '2025-06-20', 'vehiculos/listar/guardar_foto_vehiculo/sin_foto_carro.png', NULL),
('KKK222', 1, '1109491416', '9', '2002', 1241512, '2', '2025-06-15', 'vehiculos/listar/guardar_foto_vehiculo/vehiculo_685ebee958d17.jpg', NULL),
('KKK333', 8, '1109490190', '71', '2020', 202020, '6', '2025-06-18', 'vehiculos/listar/guardar_foto_vehiculo/sin_foto_carro.png', NULL),
('MAS297', 8, '1109491416', '72', '2020', 2292, '1', '2025-06-25', 'vehiculos/listar/guardar_foto_vehiculo/vehiculo_685bf370c822a.jpg', NULL),
('MOM202', 6, '1109491416', '60', '2020', 9000, '1', '2025-07-02', 'vehiculo_6868db9f9469f.jpg', NULL),
('POP321', 7, '9876543210', '68', '2020', 434343, '3', '2025-06-25', 'vehiculos/listar/guardar_foto_vehiculo/vehiculo_685bf2fbbe77f.jpg', NULL),
('RGB293', 3, '1104941185', '34', '2025', 9999, '10', '2025-07-02', 'vehiculo_686c59add7900.png', NULL),
('RIC656', 1, '1110174530', '2', '2020', 65665, '10', '2025-07-15', '../vehiculos/listar/guardar_foto_vehiculo/vehiculo_6876e3aae0b98.png', NULL),
('SIM213', 5, '1110174520', '13', '2020', 46123165, '1', '2025-07-08', 'motorhead.jpg', NULL),
('UVG099', 3, '1104941185', '32', '2015', 129000, '10', '2025-06-28', 'vehiculo_686c59bf2ad20.jpg', NULL),
('WQW222', 4, '1109490190', '48', '2020', 202020, '1', '2025-06-18', 'vehiculos/listar/guardar_foto_vehiculo/sin_foto_carro.png', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vigencia_categoria_servicio`
--

CREATE TABLE `vigencia_categoria_servicio` (
  `id_vigencia` int(11) NOT NULL,
  `id_categoria` int(11) NOT NULL,
  `id_servicio` int(11) NOT NULL,
  `edad_minima` int(11) NOT NULL,
  `vigencia_años` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `vigencia_categoria_servicio`
--

INSERT INTO `vigencia_categoria_servicio` (`id_vigencia`, `id_categoria`, `id_servicio`, `edad_minima`, `vigencia_años`) VALUES
(1, 1, 1, 16, 10),
(2, 2, 1, 16, 10),
(3, 3, 1, 18, 10),
(4, 4, 1, 20, 5),
(5, 5, 1, 21, 3),
(6, 6, 2, 18, 10),
(7, 7, 2, 20, 5),
(8, 8, 2, 21, 3);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `aseguradoras_soat`
--
ALTER TABLE `aseguradoras_soat`
  ADD PRIMARY KEY (`id_asegura`);

--
-- Indices de la tabla `categoria_licencia`
--
ALTER TABLE `categoria_licencia`
  ADD PRIMARY KEY (`id_categoria`),
  ADD KEY `id_servicio` (`id_servicio`);

--
-- Indices de la tabla `centro_rtm`
--
ALTER TABLE `centro_rtm`
  ADD PRIMARY KEY (`id_centro`);

--
-- Indices de la tabla `clasificacion_trabajo`
--
ALTER TABLE `clasificacion_trabajo`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `contacto`
--
ALTER TABLE `contacto`
  ADD PRIMARY KEY (`id_mensa`);

--
-- Indices de la tabla `correos_enviados_licencia`
--
ALTER TABLE `correos_enviados_licencia`
  ADD PRIMARY KEY (`id_correos`),
  ADD KEY `id_licencia` (`id_licencia`);

--
-- Indices de la tabla `correos_enviados_llantas`
--
ALTER TABLE `correos_enviados_llantas`
  ADD PRIMARY KEY (`id_correo`),
  ADD KEY `id_llantas` (`id_llantas`);

--
-- Indices de la tabla `correos_enviados_mantenimiento`
--
ALTER TABLE `correos_enviados_mantenimiento`
  ADD PRIMARY KEY (`id_correo`),
  ADD KEY `id_mantenimiento` (`id_mantenimiento`);

--
-- Indices de la tabla `correos_enviados_pico_placa`
--
ALTER TABLE `correos_enviados_pico_placa`
  ADD PRIMARY KEY (`id_correos`),
  ADD KEY `placa` (`placa`);

--
-- Indices de la tabla `correos_enviados_soat`
--
ALTER TABLE `correos_enviados_soat`
  ADD PRIMARY KEY (`id_correos`),
  ADD KEY `id_soat` (`id_soat`);

--
-- Indices de la tabla `correos_enviados_tecno`
--
ALTER TABLE `correos_enviados_tecno`
  ADD PRIMARY KEY (`id_correo`),
  ADD KEY `id_rtm` (`id_rtm`);

--
-- Indices de la tabla `detalles_mantenimiento_clasificacion`
--
ALTER TABLE `detalles_mantenimiento_clasificacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_mantenimiento` (`id_mantenimiento`),
  ADD KEY `id_trabajo` (`id_trabajo`);

--
-- Indices de la tabla `empresas`
--
ALTER TABLE `empresas`
  ADD PRIMARY KEY (`id_empresa`),
  ADD UNIQUE KEY `nit` (`nit`);

--
-- Indices de la tabla `estado_soat`
--
ALTER TABLE `estado_soat`
  ADD PRIMARY KEY (`id_stado`);

--
-- Indices de la tabla `estado_usuario`
--
ALTER TABLE `estado_usuario`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `estado_vehiculo`
--
ALTER TABLE `estado_vehiculo`
  ADD PRIMARY KEY (`id_estado`);

--
-- Indices de la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documento_usuario` (`documento_usuario`);

--
-- Indices de la tabla `licencias`
--
ALTER TABLE `licencias`
  ADD PRIMARY KEY (`id_licencia`),
  ADD KEY `id_documento` (`id_documento`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_servicio` (`id_servicio`);

--
-- Indices de la tabla `licencias_sistema`
--
ALTER TABLE `licencias_sistema`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave_licencia` (`clave_licencia`),
  ADD KEY `documento_usuario` (`documento_usuario`);

--
-- Indices de la tabla `licencia_log`
--
ALTER TABLE `licencia_log`
  ADD PRIMARY KEY (`id_log`);

--
-- Indices de la tabla `llantas`
--
ALTER TABLE `llantas`
  ADD PRIMARY KEY (`id_llanta`),
  ADD KEY `placa` (`placa`);

--
-- Indices de la tabla `llantas_log`
--
ALTER TABLE `llantas_log`
  ADD PRIMARY KEY (`id_log`);

--
-- Indices de la tabla `logs_sistema`
--
ALTER TABLE `logs_sistema`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `log_accesos_superadmin`
--
ALTER TABLE `log_accesos_superadmin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documento` (`documento`),
  ADD KEY `fecha_acceso` (`fecha_acceso`);

--
-- Indices de la tabla `log_registros`
--
ALTER TABLE `log_registros`
  ADD PRIMARY KEY (`id_log`);

--
-- Indices de la tabla `mantenimiento`
--
ALTER TABLE `mantenimiento`
  ADD PRIMARY KEY (`id_mantenimiento`),
  ADD KEY `placa` (`placa`),
  ADD KEY `id_tipo_mantenimiento` (`id_tipo_mantenimiento`);

--
-- Indices de la tabla `mantenimiento_log`
--
ALTER TABLE `mantenimiento_log`
  ADD PRIMARY KEY (`id_log`);

--
-- Indices de la tabla `marca`
--
ALTER TABLE `marca`
  ADD PRIMARY KEY (`id_marca`),
  ADD KEY `fk_marca_tipo` (`id_tipo_vehiculo`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `documento_usuario` (`documento_usuario`);

--
-- Indices de la tabla `pico_placa`
--
ALTER TABLE `pico_placa`
  ADD PRIMARY KEY (`id_pico_placa`);

--
-- Indices de la tabla `registro_vehiculos_log`
--
ALTER TABLE `registro_vehiculos_log`
  ADD PRIMARY KEY (`id_log`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id_rol`);

--
-- Indices de la tabla `servicios_licencias`
--
ALTER TABLE `servicios_licencias`
  ADD PRIMARY KEY (`id_servicio`);

--
-- Indices de la tabla `sistema_licencias`
--
ALTER TABLE `sistema_licencias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `clave_licencia` (`clave_licencia`),
  ADD KEY `usuario_asignado` (`usuario_asignado`);

--
-- Indices de la tabla `soat`
--
ALTER TABLE `soat`
  ADD PRIMARY KEY (`id_soat`),
  ADD KEY `id_placa` (`id_placa`),
  ADD KEY `id_aseguradora` (`id_aseguradora`),
  ADD KEY `id-estado` (`id_estado`);

--
-- Indices de la tabla `soat_log`
--
ALTER TABLE `soat_log`
  ADD PRIMARY KEY (`id_log`);

--
-- Indices de la tabla `talleres`
--
ALTER TABLE `talleres`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tecnomecanica`
--
ALTER TABLE `tecnomecanica`
  ADD PRIMARY KEY (`id_rtm`),
  ADD KEY `id_centro_revision` (`id_centro_revision`),
  ADD KEY `id_estado` (`id_estado`),
  ADD KEY `id_placa` (`id_placa`);

--
-- Indices de la tabla `tecnomecanica_log`
--
ALTER TABLE `tecnomecanica_log`
  ADD PRIMARY KEY (`id_log`);

--
-- Indices de la tabla `tipo_documentacion`
--
ALTER TABLE `tipo_documentacion`
  ADD PRIMARY KEY (`id_tipo_documento`);

--
-- Indices de la tabla `tipo_gasto`
--
ALTER TABLE `tipo_gasto`
  ADD PRIMARY KEY (`id_tipo_gasto`);

--
-- Indices de la tabla `tipo_mantenimiento`
--
ALTER TABLE `tipo_mantenimiento`
  ADD PRIMARY KEY (`id_tipo_mantenimiento`);

--
-- Indices de la tabla `tipo_vehiculo`
--
ALTER TABLE `tipo_vehiculo`
  ADD PRIMARY KEY (`id_tipo_vehiculo`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`documento`),
  ADD KEY `id_estado_usuario` (`id_estado_usuario`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `fk_usuarios_empresa` (`nit_empresa`);

--
-- Indices de la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD PRIMARY KEY (`placa`),
  ADD KEY `id_marca` (`id_marca`),
  ADD KEY `id_estado` (`id_estado`),
  ADD KEY `Documento` (`Documento`),
  ADD KEY `tipo_vehiculo` (`tipo_vehiculo`);

--
-- Indices de la tabla `vigencia_categoria_servicio`
--
ALTER TABLE `vigencia_categoria_servicio`
  ADD PRIMARY KEY (`id_vigencia`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_servicio` (`id_servicio`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `aseguradoras_soat`
--
ALTER TABLE `aseguradoras_soat`
  MODIFY `id_asegura` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `categoria_licencia`
--
ALTER TABLE `categoria_licencia`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `centro_rtm`
--
ALTER TABLE `centro_rtm`
  MODIFY `id_centro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `clasificacion_trabajo`
--
ALTER TABLE `clasificacion_trabajo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `contacto`
--
ALTER TABLE `contacto`
  MODIFY `id_mensa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de la tabla `correos_enviados_licencia`
--
ALTER TABLE `correos_enviados_licencia`
  MODIFY `id_correos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `correos_enviados_llantas`
--
ALTER TABLE `correos_enviados_llantas`
  MODIFY `id_correo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `correos_enviados_mantenimiento`
--
ALTER TABLE `correos_enviados_mantenimiento`
  MODIFY `id_correo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `correos_enviados_pico_placa`
--
ALTER TABLE `correos_enviados_pico_placa`
  MODIFY `id_correos` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `correos_enviados_soat`
--
ALTER TABLE `correos_enviados_soat`
  MODIFY `id_correos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `correos_enviados_tecno`
--
ALTER TABLE `correos_enviados_tecno`
  MODIFY `id_correo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalles_mantenimiento_clasificacion`
--
ALTER TABLE `detalles_mantenimiento_clasificacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `empresas`
--
ALTER TABLE `empresas`
  MODIFY `id_empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `estado_soat`
--
ALTER TABLE `estado_soat`
  MODIFY `id_stado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `estado_usuario`
--
ALTER TABLE `estado_usuario`
  MODIFY `id_estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `eventos`
--
ALTER TABLE `eventos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `licencias`
--
ALTER TABLE `licencias`
  MODIFY `id_licencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `licencias_sistema`
--
ALTER TABLE `licencias_sistema`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `licencia_log`
--
ALTER TABLE `licencia_log`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `llantas`
--
ALTER TABLE `llantas`
  MODIFY `id_llanta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `llantas_log`
--
ALTER TABLE `llantas_log`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `logs_sistema`
--
ALTER TABLE `logs_sistema`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1109491417;

--
-- AUTO_INCREMENT de la tabla `log_accesos_superadmin`
--
ALTER TABLE `log_accesos_superadmin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `log_registros`
--
ALTER TABLE `log_registros`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `mantenimiento`
--
ALTER TABLE `mantenimiento`
  MODIFY `id_mantenimiento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `mantenimiento_log`
--
ALTER TABLE `mantenimiento_log`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `marca`
--
ALTER TABLE `marca`
  MODIFY `id_marca` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `pico_placa`
--
ALTER TABLE `pico_placa`
  MODIFY `id_pico_placa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `registro_vehiculos_log`
--
ALTER TABLE `registro_vehiculos_log`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `servicios_licencias`
--
ALTER TABLE `servicios_licencias`
  MODIFY `id_servicio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `sistema_licencias`
--
ALTER TABLE `sistema_licencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `soat`
--
ALTER TABLE `soat`
  MODIFY `id_soat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `soat_log`
--
ALTER TABLE `soat_log`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `talleres`
--
ALTER TABLE `talleres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de la tabla `tecnomecanica`
--
ALTER TABLE `tecnomecanica`
  MODIFY `id_rtm` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tecnomecanica_log`
--
ALTER TABLE `tecnomecanica_log`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `vigencia_categoria_servicio`
--
ALTER TABLE `vigencia_categoria_servicio`
  MODIFY `id_vigencia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `categoria_licencia`
--
ALTER TABLE `categoria_licencia`
  ADD CONSTRAINT `categoria_licencia_ibfk_1` FOREIGN KEY (`id_servicio`) REFERENCES `servicios_licencias` (`id_servicio`);

--
-- Filtros para la tabla `correos_enviados_licencia`
--
ALTER TABLE `correos_enviados_licencia`
  ADD CONSTRAINT `correos_enviados_licencia_ibfk_1` FOREIGN KEY (`id_licencia`) REFERENCES `licencias` (`id_licencia`);

--
-- Filtros para la tabla `correos_enviados_llantas`
--
ALTER TABLE `correos_enviados_llantas`
  ADD CONSTRAINT `correos_enviados_llantas_ibfk_1` FOREIGN KEY (`id_llantas`) REFERENCES `llantas` (`id_llanta`);

--
-- Filtros para la tabla `correos_enviados_mantenimiento`
--
ALTER TABLE `correos_enviados_mantenimiento`
  ADD CONSTRAINT `correos_enviados_mantenimiento_ibfk_1` FOREIGN KEY (`id_mantenimiento`) REFERENCES `mantenimiento` (`id_mantenimiento`);

--
-- Filtros para la tabla `correos_enviados_pico_placa`
--
ALTER TABLE `correos_enviados_pico_placa`
  ADD CONSTRAINT `correos_enviados_pico_placa_ibfk_1` FOREIGN KEY (`placa`) REFERENCES `vehiculos` (`placa`);

--
-- Filtros para la tabla `correos_enviados_soat`
--
ALTER TABLE `correos_enviados_soat`
  ADD CONSTRAINT `correos_enviados_soat_ibfk_1` FOREIGN KEY (`id_soat`) REFERENCES `soat` (`id_soat`);

--
-- Filtros para la tabla `correos_enviados_tecno`
--
ALTER TABLE `correos_enviados_tecno`
  ADD CONSTRAINT `correos_enviados_tecno_ibfk_1` FOREIGN KEY (`id_rtm`) REFERENCES `tecnomecanica` (`id_rtm`);

--
-- Filtros para la tabla `detalles_mantenimiento_clasificacion`
--
ALTER TABLE `detalles_mantenimiento_clasificacion`
  ADD CONSTRAINT `detalles_mantenimiento_clasificacion_ibfk_1` FOREIGN KEY (`id_mantenimiento`) REFERENCES `mantenimiento` (`id_mantenimiento`),
  ADD CONSTRAINT `detalles_mantenimiento_clasificacion_ibfk_2` FOREIGN KEY (`id_trabajo`) REFERENCES `clasificacion_trabajo` (`id`);

--
-- Filtros para la tabla `eventos`
--
ALTER TABLE `eventos`
  ADD CONSTRAINT `eventos_ibfk_1` FOREIGN KEY (`documento_usuario`) REFERENCES `usuarios` (`documento`);

--
-- Filtros para la tabla `licencias`
--
ALTER TABLE `licencias`
  ADD CONSTRAINT `licencias_ibfk_1` FOREIGN KEY (`id_documento`) REFERENCES `usuarios` (`documento`),
  ADD CONSTRAINT `licencias_ibfk_2` FOREIGN KEY (`id_categoria`) REFERENCES `categoria_licencia` (`id_categoria`),
  ADD CONSTRAINT `licencias_ibfk_3` FOREIGN KEY (`id_servicio`) REFERENCES `servicios_licencias` (`id_servicio`);

--
-- Filtros para la tabla `licencias_sistema`
--
ALTER TABLE `licencias_sistema`
  ADD CONSTRAINT `licencias_sistema_ibfk_1` FOREIGN KEY (`documento_usuario`) REFERENCES `usuarios` (`documento`);

--
-- Filtros para la tabla `llantas`
--
ALTER TABLE `llantas`
  ADD CONSTRAINT `llantas_ibfk_1` FOREIGN KEY (`placa`) REFERENCES `vehiculos` (`placa`) ON DELETE CASCADE;

--
-- Filtros para la tabla `mantenimiento`
--
ALTER TABLE `mantenimiento`
  ADD CONSTRAINT `mantenimiento_ibfk_1` FOREIGN KEY (`placa`) REFERENCES `vehiculos` (`placa`),
  ADD CONSTRAINT `mantenimiento_ibfk_2` FOREIGN KEY (`id_tipo_mantenimiento`) REFERENCES `tipo_mantenimiento` (`id_tipo_mantenimiento`);

--
-- Filtros para la tabla `marca`
--
ALTER TABLE `marca`
  ADD CONSTRAINT `fk_marca_tipo` FOREIGN KEY (`id_tipo_vehiculo`) REFERENCES `tipo_vehiculo` (`id_tipo_vehiculo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`documento_usuario`) REFERENCES `usuarios` (`documento`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `sistema_licencias`
--
ALTER TABLE `sistema_licencias`
  ADD CONSTRAINT `sistema_licencias_ibfk_1` FOREIGN KEY (`usuario_asignado`) REFERENCES `usuarios` (`documento`) ON DELETE CASCADE;

--
-- Filtros para la tabla `soat`
--
ALTER TABLE `soat`
  ADD CONSTRAINT `soat_ibfk_1` FOREIGN KEY (`id_placa`) REFERENCES `vehiculos` (`placa`),
  ADD CONSTRAINT `soat_ibfk_2` FOREIGN KEY (`id_aseguradora`) REFERENCES `aseguradoras_soat` (`id_asegura`),
  ADD CONSTRAINT `soat_ibfk_3` FOREIGN KEY (`id_estado`) REFERENCES `estado_soat` (`id_stado`);

--
-- Filtros para la tabla `tecnomecanica`
--
ALTER TABLE `tecnomecanica`
  ADD CONSTRAINT `tecnomecanica_ibfk_1` FOREIGN KEY (`id_centro_revision`) REFERENCES `centro_rtm` (`id_centro`),
  ADD CONSTRAINT `tecnomecanica_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `estado_soat` (`id_stado`),
  ADD CONSTRAINT `tecnomecanica_ibfk_3` FOREIGN KEY (`id_placa`) REFERENCES `vehiculos` (`placa`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `fk_usuarios_empresa` FOREIGN KEY (`nit_empresa`) REFERENCES `empresas` (`nit`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_estado_usuario`) REFERENCES `estado_usuario` (`id_estado`),
  ADD CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id_rol`);

--
-- Filtros para la tabla `vehiculos`
--
ALTER TABLE `vehiculos`
  ADD CONSTRAINT `fk_vehiculos_documento` FOREIGN KEY (`Documento`) REFERENCES `usuarios` (`documento`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `vehiculos_ibfk_3` FOREIGN KEY (`id_estado`) REFERENCES `estado_vehiculo` (`id_estado`),
  ADD CONSTRAINT `vehiculos_ibfk_4` FOREIGN KEY (`tipo_vehiculo`) REFERENCES `tipo_vehiculo` (`id_tipo_vehiculo`);

--
-- Filtros para la tabla `vigencia_categoria_servicio`
--
ALTER TABLE `vigencia_categoria_servicio`
  ADD CONSTRAINT `vigencia_categoria_servicio_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categoria_licencia` (`id_categoria`),
  ADD CONSTRAINT `vigencia_categoria_servicio_ibfk_2` FOREIGN KEY (`id_servicio`) REFERENCES `servicios_licencias` (`id_servicio`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
