<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Mapa de Talleres</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
    <style>
        #map {
            height: 500px;
            width: 100%;
            margin: 20px auto;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        body {
            font-family: 'Poppins', sans-serif;
            padding: 20px;
            text-align: center;
        }

        .boton {
            margin-top: 20px;
            display: inline-block;
            padding: 10px 20px;
            background-color: #198754;
            color: white;
            border-radius: 10px;
            font-weight: bold;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .boton:hover {
            background-color: #157347;
        }
    </style>
</head>
<body>
    <h2><i class="bi bi-geo-alt-fill"></i> Talleres Cercanos</h2>
    <div id="map"></div>
    <a href="../index.php" class="boton">Volver al inicio</a>

    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <script>
        const map = L.map('map').setView([4.444354, -75.242886], 13); // Coordenadas de Ibagué

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© OpenStreetMap contributors'
        }).addTo(map);

        // Marcador de ubicación del usuario (opcional)
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (position) {
                const userLat = position.coords.latitude;
                const userLng = position.coords.longitude;

                L.marker([userLat, userLng])
                    .addTo(map)
                    .bindPopup("Usted está aquí")
                    .openPopup();

                map.setView([userLat, userLng], 14);
            });
        }

        // Cargar los talleres desde PHP
        fetch('obtener_taller.php')
            .then(res => res.json())
            .then(talleres => {
                talleres.forEach(t => {
                    L.marker([t.latitud, t.longitud])
                        .addTo(map)
                        .bindPopup(`<b>${t.nombre}</b><br>${t.direccion}<br>📞 ${t.telefono}`);
                });
            });
    </script>
</body>
</html>
