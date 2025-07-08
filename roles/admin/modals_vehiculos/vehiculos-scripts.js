document.addEventListener('DOMContentLoaded', () => {
    // Inicializar modales
    const agregarVehiculoModal = new bootstrap.Modal(document.getElementById('modalAgregarVehiculo'), { keyboard: false });
    const editarVehiculoModal = new bootstrap.Modal(document.getElementById('editarVehiculoModal'), { keyboard: false });
    const eliminarVehiculoModal = new bootstrap.Modal(document.getElementById('eliminarVehiculoModal'), { keyboard: false });

    // Botón para abrir el modal de agregar vehículo
    document.getElementById('btnAgregarVehiculo').addEventListener('click', () => {
        const form = document.getElementById('agregarVehiculoForm');
        form.reset(); // Limpiar el formulario
        document.getElementById('foto_vehiculo_preview').style.display = 'none'; // Ocultar vista previa
        agregarVehiculoModal.show();
    });

    // Delegar evento para botones de editar
    document.addEventListener('click', (e) => {
        const btnEdit = e.target.closest('.action-icon.edit');
        if (btnEdit) {
            const placa = btnEdit.getAttribute('data-id');
            fetchVehicleData(placa);
        }
    });

    // Delegar evento para botones de eliminar
    document.addEventListener('click', (e) => {
        const btnDelete = e.target.closest('.action-icon.delete');
        if (btnDelete) {
            const placa = btnDelete.getAttribute('data-id');
            document.getElementById('deletePlaca').textContent = placa;
            document.getElementById('confirmarEliminar').setAttribute('data-id', placa);
            eliminarVehiculoModal.show();
        }
    });

    // Función para obtener datos del vehículo
    function fetchVehicleData(placa) {
        fetch(`modals_vehiculos/get_vehicle.php?placa=${encodeURIComponent(placa)}`, {
            method: 'GET',
            headers: { 'Accept': 'application/json' }
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Error HTTP: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                if (data.error) {
                    alert(`Error al cargar los datos del vehículo: ${data.error}`);
                    return;
                }
                document.getElementById('editPlaca').value = data.placa || '';
                document.getElementById('editDocumento').value = data.Documento || '';
                document.getElementById('editMarca').value = data.id_marca || '';
                document.getElementById('editModelo').value = data.modelo || '';
                document.getElementById('editKilometraje').value = data.kilometraje_actual || '';
                document.getElementById('editEstado').value = data.id_estado || '';

                const fotoPreview = document.getElementById('editFotoPreview');
                if (data.foto_vehiculo && data.foto_vehiculo !== 'sin_foto_carro.png') {
                    fotoPreview.src = `../../roles/usuario/vehiculos/listar/guardar_foto_vehiculo/${data.foto_vehiculo}`;
                    fotoPreview.style.display = 'block';
                } else {
                    fotoPreview.style.display = 'none';
                    fotoPreview.src = '';
                }
                editarVehiculoModal.show();
            })
            .catch(error => {
                console.error('Error al cargar datos del vehículo:', error);
                alert(`Error al cargar los datos del vehículo: ${error.message}`);
            });
    }

    // Previsualización de imagen al editar
    document.getElementById('editFoto').addEventListener('change', function (event) {
        const file = event.target.files[0];
        const preview = document.getElementById('editFotoPreview');
        if (file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                preview.src = e.target.result;
                preview.style.display = 'block';
            };
            reader.readAsDataURL(file);
        } else {
            preview.style.display = 'none';
            preview.src = '';
        }
    });

    // Previsualización de imagen al agregar
    document.getElementById('foto_vehiculo').addEventListener('change', function (event) {
        const file = event.target.files[0];
        const preview = document.getElementById('foto_vehiculo_preview');
        if (file) {
            const reader = new FileReader();
            reader.onload = (e) => {
                preview.src = e.target.result;
                preview.style.display = 'block';
            };
            reader.readAsDataURL(file);
        } else {
            preview.style.display = 'none';
            preview.src = '';
        }
    });

    // Enviar formulario de agregar vehículo
    document.getElementById('agregarVehiculoForm').addEventListener('submit', function (e) {
    e.preventDefault();
    const formData = new FormData(this);

    fetch('modals_vehiculos/agregar_vehiculo.php', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(text => {
        let data;
        try {
            data = JSON.parse(text);
        } catch (e) {
            console.error('Respuesta no es JSON:', text);
            throw new Error('La respuesta del servidor no es un JSON válido.');
        }
        console.log('Respuesta del servidor:', data);
        if (data.success) {
            alert(data.message || 'Vehículo agregado exitosamente.');
            agregarVehiculoModal.hide();
            location.reload();
        } else {
            alert(`Error al agregar el vehículo: ${data.error || 'Sin detalles del error'}`);
            if (data.error && data.error.includes('La placa ya está registrada')) {
                if (confirm('La placa ya existe. ¿Desea editar el vehículo existente?')) {
                    fetchVehicleData(formData.get('placa'));
                }
            }
        }
    })
    .catch(error => {
        console.error('Error al agregar vehículo:', error);
        alert(`Error al procesar la solicitud: ${error.message}`);
    });
});

    // Enviar formulario de editar vehículo
    document.getElementById('editarVehiculoForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const formData = new FormData(this);

        // Depuración: Mostrar datos enviados
        for (let [key, value] of formData.entries()) {
            console.log(`Enviando ${key}: ${value}`);
        }

        fetch('modals_vehiculos/update_vehicle.php', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Error HTTP: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                console.log('Respuesta del servidor:', data);
                if (data.success) {
                    alert('Vehículo actualizado exitosamente.');
                    editarVehiculoModal.hide();
                    location.reload();
                } else {
                    alert(`Error al actualizar el vehículo: ${data.error}`);
                }
            })
            .catch(error => {
                console.error('Error al actualizar vehículo:', error);
                alert(`Error al procesar la solicitud: ${error.message}`);
            });
    });

    // Confirmar eliminación de vehículo
    document.getElementById('confirmarEliminar').addEventListener('click', function () {
        const placa = this.getAttribute('data-id');
        fetch('modals_vehiculos/delete_vehicle.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: `placa=${encodeURIComponent(placa)}`
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error(`Error HTTP: ${response.status}`);
                }
                return response.json();
            })
            .then(data => {
                console.log('Respuesta del servidor:', data);
                if (data.success) {
                    alert('Vehículo eliminado exitosamente.');
                    eliminarVehiculoModal.hide();
                    location.reload();
                } else {
                    alert(`Error al eliminar el vehículo: ${data.error}`);
                }
            })
            .catch(error => {
                console.error('Error al eliminar vehículo:', error);
                alert(`Error al procesar la solicitud: ${error.message}`);
            });
    });
});